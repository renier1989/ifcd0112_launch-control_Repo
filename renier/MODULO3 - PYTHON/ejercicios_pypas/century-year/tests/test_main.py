import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    (1705, 18),
    (1900, 19),
    (1601, 17),
    (2000, 20),
    (1999, 20),
]


@pytest.mark.parametrize('year, expected', testdata)
def test_run(year, expected):
    assert main.run(year) == expected
