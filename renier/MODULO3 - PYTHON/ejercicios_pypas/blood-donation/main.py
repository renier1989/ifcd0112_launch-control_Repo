def run(age: int, weight: int, heartbeat: int, platelets: int) -> bool:
    suitable_for_donation = True if (18 <= age <= 65 ) \
        and (weight > 50 ) \
        and ( 50 <= heartbeat <= 110 ) \
        and (platelets > 150000) \
        else False
        
    return suitable_for_donation


# DO NOT TOUCH THE CODE BELOW
if __name__ == '__main__':
    import vendor

    vendor.launch(run)
