import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    (3, 3, 4.5),
    (1, 100, 50.0),
    (9.99, 3.11, 15.53445),
]


@pytest.mark.parametrize('base, height, expected', testdata)
def test_run(base, height, expected):
    assert main.run(base, height) == expected
