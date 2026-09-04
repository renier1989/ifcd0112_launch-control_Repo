def run(can_fly: bool, is_human: bool, has_mask: bool) -> str:
    character = 'Ironman' if (can_fly and is_human and has_mask) else 'Captain Marvel' if (can_fly and is_human and not has_mask) else 'Ronan Accuser' if (can_fly and not is_human and has_mask) else 'Vision' if (can_fly and not is_human and not has_mask) else 'Spiderman' if (not can_fly and is_human and has_mask) else 'Hulk' if (not can_fly and is_human and not has_mask) else 'Black Bolt' if (not can_fly and not is_human and has_mask) else 'Thanos'

    return character


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
