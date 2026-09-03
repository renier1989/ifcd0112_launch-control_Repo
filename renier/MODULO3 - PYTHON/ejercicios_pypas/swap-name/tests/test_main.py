import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    ('Sergio', 'Delgado Quintero', 'Delgado Quintero, Sergio'),
    ('Grace', 'Hopper', 'Hopper, Grace'),
    ('Guido', 'Van Rossum', 'Van Rossum, Guido'),
]


@pytest.mark.parametrize('name, surname, expected', testdata)
def test_run(name, surname, expected):
    assert main.run(name, surname) == expected
