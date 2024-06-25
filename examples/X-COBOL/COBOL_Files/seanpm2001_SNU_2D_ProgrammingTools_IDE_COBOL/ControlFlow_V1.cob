EVALUATE TRUE ALSO desired-speed ALSO current-speed
    WHEN lid-closed ALSO min-speed THRU max-speed ALSO LESS THAN desired-speed
        PERFORM speed-up-machine
    WHEN lid-closed ALSO min-speed THRU max-speed ALSO GREATER THAN desired-speed
        PERFORM slow-down-machine
    WHEN lid-open ALSO ANY ALSO NOT ZERO
        PERFORM emergency-stop
    WHEN OTHER
        CONTINUE
END-EVALUATE
