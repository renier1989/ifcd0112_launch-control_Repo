import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    (45_782, '#00B2D6'),
    (4_098_423, '#3E8977'),
    (527, '#00020F'),
    (832_923, '#0CB59B'),
]


@pytest.mark.parametrize('intcolor, expected', testdata)
def test_run(intcolor, expected):
    assert main.run(intcolor) == expected
