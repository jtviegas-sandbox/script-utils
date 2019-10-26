#!/bin/sh

# should install pipx with brew and then pipenv
# brew install pipx
# pipx install pipenv

this_folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
parent_folder=$(dirname $this_folder)

# parameter check
usage()
{
        cat <<EOM
        usage:
        $(basename $0) <project name>
EOM
        exit 1
}

[ -z $1 ] && { usage; }

__name=$1

mkdir $__name
cd $__name

pipenv install black isort --dev --pre

cat > setup.cfg <<FILE
[isort]
multi_line_output=3
include_trailing_comma=True
force_grid_wrap=0
use_parentheses=True
line_length=88
FILE

pipenv install flake8 --dev

cat >> setup.cfg <<FILE
[flake8]
ignore = E203, E266, E501, W503
max-line-length = 88
max-complexity = 18
select = B,C,E,F,W,T4
FILE

pipenv install pytest pytest-cov --dev

cat >> setup.cfg <<FILE
[tool:pytest]
testpaths=test
FILE


mkdir test
cat > test/test_sample.py <<FILE
def inc(x):
    return x + 1
def test_answer():
    assert inc(3) == 5
FILE

pipenv run pytest

cat > .coveragerc <<FILE
[run]
source = best_practices

[report]
exclude_lines =
    # Have to re-enable the standard pragma
    pragma: no cover

    # Don't complain about missing debug-only code:
    def __repr__
    if self\.debug

    # Don't complain if tests don't hit defensive assertion code:
    raise AssertionError
    raise NotImplementedError

    # Don't complain if non-runnable code isn't run:
    if 0:
    if __name__ == .__main__.:
FILE

pipenv run pytest --cov --cov-fail-under=100

cat > .pre-commit-config.yaml <<FILE
repos:
- repo: local
  hooks:
  - id: isort
    name: isort
    stages: [commit]
    language: system
    entry: pipenv run isort
    types: [python]

  - id: black
    name: black
    stages: [commit]
    language: system
    entry: pipenv run black
    types: [python]

  - id: flake8
    name: flake8
    stages: [commit]
    language: system
    entry: pipenv run flake8
    types: [python]
    exclude: setup.py

  - id: pytest
    name: pytest
    stages: [commit]
    language: system
    entry: pipenv run pytest
    types: [python]

  - id: pytest-cov
    name: pytest
    stages: [push]
    language: system
    entry: pipenv run pytest --cov --cov-fail-under=75
    types: [python]
    pass_filenames: false

FILE


cd ${this_folder}
