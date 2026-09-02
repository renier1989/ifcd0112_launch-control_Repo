import os

import pytest

if os.path.exists('solution.py'):
    import solution as main
else:
    import main  # type:ignore

testdata = [
    (10_000, 3.5, 7, 12722.792627665729),
    (7_500, 0.25, 21, 7903.751377796907),
    (125_000, 0.045, 9, 125507.16220745872),
]


@pytest.mark.parametrize('amount, rate, years, expected', testdata)
def test_run(amount, rate, years, expected):
    assert main.run(amount, rate, years) == expected
