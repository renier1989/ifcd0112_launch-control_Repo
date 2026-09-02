import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    (3, 5, -7, -4, 13.45362404707371),
    (2.1, 4.3, -2.3, 8.5, 6.082762530298219),
    (0.1, 0.2, -0.1, -0.2, 0.447213595499958),
]


@pytest.mark.parametrize('x1, y1, x2, y2, expected', testdata)
def test_run(x1, y1, x2, y2, expected):
    assert main.run(x1, y1, x2, y2) == expected
