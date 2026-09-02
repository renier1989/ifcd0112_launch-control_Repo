def run(current_pos: int, dice: int) -> int:
    sum = dice * 2
    final_pos = ( current_pos + sum ) 
    return final_pos


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
