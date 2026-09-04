import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    (0, ''),
    (3, 'sheep...sheep...sheep...'),
    (5, 'sheep...sheep...sheep...sheep...sheep...'),
    (7, 'sheep...sheep...sheep...sheep...sheep...sheep...sheep...'),
]


@pytest.mark.parametrize('num_sheeps, expected', testdata)
def test_run(num_sheeps, expected):
    assert main.run(num_sheeps) == expected
