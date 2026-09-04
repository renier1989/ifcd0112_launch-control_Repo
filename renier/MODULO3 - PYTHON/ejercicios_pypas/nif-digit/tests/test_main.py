import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    ('78654355', '78654355J'),
    ('65895421', '65895421F'),
    ('43298006', '43298006T'),
]


@pytest.mark.parametrize('nif, expected', testdata)
def test_run(nif, expected):
    assert main.run(nif) == expected
