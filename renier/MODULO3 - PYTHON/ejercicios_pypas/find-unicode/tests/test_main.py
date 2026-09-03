import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    ('δ', -2, 'β'),
    ('μ', 4, 'π'),
    ('φ', 0, 'φ'),
]


@pytest.mark.parametrize('source_char, offset, expected', testdata)
def test_run(source_char, offset, expected):
    assert main.run(source_char, offset) == expected
