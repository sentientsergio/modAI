      *========================== COB-FAKER ===========================*
      * Authors: Brian D Pead
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

      **** FORMAT CODES:
      ****     FF = first_name_female
      ****     FM = first_name_male
      ****     LN = last_name
      ****     PF = prefix_female
      ****     PM = prefix_male
      ****     SF = suffix_female
      ****     SM = suffix_male

       01  FORMATS-FEMALE.
           05  FORMAT-FEMALE-CNT   PIC S9(4)  COMP VALUE 8.
           05  FORMAT-FEMALE-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  FORMAT-FEMALE-OCCS.
               10  FILLER          PIC X(32)       VALUE '{FF} {LN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.770000000.
               10  FILLER          PIC X(32)       VALUE 
                                                       '{PF} {FF} {LN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.050000000.
               10  FILLER          PIC X(32)       VALUE
                                                       '{FF} {LN} {SF}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.050000000.
               10  FILLER          PIC X(32)       VALUE 
                                                  '{PF} {FF} {LN} {SF}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.050000000.
               10  FILLER          PIC X(32)       VALUE 
                                                       '{FF} {LN}-{LN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.050000000.
               10  FILLER          PIC X(32)       VALUE 
                                                  '{PF} {FF} {LN}-{LN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010000000.
               10  FILLER          PIC X(32)       VALUE
                                                  '{FF} {LN}-{LN} {SF}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010000000.
               10  FILLER          PIC X(32)       VALUE 
                                             '{PF} {FF} {LN}-{LN} {SF}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010000000.
           05  FILLER REDEFINES FORMAT-FEMALE-OCCS.
               10  FILLER                          OCCURS 8
                                                   INDEXED FF-DX.
                   15  FORMAT-FEMALE 
                                   PIC X(32).
                   15  FORMAT-FEMALE-WEIGHT
                                   PIC SV9(9) COMP.

       01  FORMATS-MALE.
           05  FORMAT-MALE-CNT     PIC S9(4)  COMP VALUE 8.
           05  FORMAT-MALE-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  FORMAT-MALE-OCCS.
               10  FILLER          PIC X(32)       VALUE '{FM} {LN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.770000000.
               10  FILLER          PIC X(32)       VALUE 
                                                       '{PM} {FM} {LN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.050000000.
               10  FILLER          PIC X(32)       VALUE
                                                       '{FM} {LN} {SM}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.050000000.
               10  FILLER          PIC X(32)       VALUE 
                                                  '{PM} {FM} {LN} {SM}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.050000000.
               10  FILLER          PIC X(32)       VALUE 
                                                       '{FM} {LN}-{LN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.050000000.
               10  FILLER          PIC X(32)       VALUE 
                                                  '{PM} {FM} {LN}-{LN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010000000.
               10  FILLER          PIC X(32)       VALUE
                                                  '{FM} {LN}-{LN} {SM}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010000000.
               10  FILLER          PIC X(32)       VALUE 
                                             '{PM} {FM} {LN}-{LN} {SM}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010000000.
           05  FILLER REDEFINES FORMAT-MALE-OCCS.
               10  FILLER                          OCCURS 8
                                                   INDEXED FM-DX.
                   15  FORMAT-MALE 
                                   PIC X(32).
                   15  FORMAT-MALE-WEIGHT
                                   PIC SV9(9) COMP.

      * Top 200 names of the decade from the 60's-90's from:
      * https://www.ssa.gov/OACT/babynames/decades/names1960s.html
      * Weightings derived from total number on each name

       01  FIRST-NAMES-FEMALE.
           05  FIRST-NAME-FEMALE-CNT
                                   PIC S9(4)  COMP VALUE 381.
           05  FIRST-NAME-FEMALE-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  FIRST-NAME-FEMALE-OCCS.
               10  FILLER          PIC X(12)       VALUE 'April'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004529083.
               10  FILLER          PIC X(12)       VALUE 'Abigail'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002043839.
               10  FILLER          PIC X(12)       VALUE 'Adriana'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000488767.
               10  FILLER          PIC X(12)       VALUE 'Adrienne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000622931.
               10  FILLER          PIC X(12)       VALUE 'Aimee'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000424727.
               10  FILLER          PIC X(12)       VALUE 'Alejandra'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000415754.
               10  FILLER          PIC X(12)       VALUE 'Alexa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000663005.
               10  FILLER          PIC X(12)       VALUE 'Alexandra'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002835711.
               10  FILLER          PIC X(12)       VALUE 'Alexandria'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000964993.
               10  FILLER          PIC X(12)       VALUE 'Alexis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003446735.
               10  FILLER          PIC X(12)       VALUE 'Alice'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000589904.
               10  FILLER          PIC X(12)       VALUE 'Alicia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003766845.
               10  FILLER          PIC X(12)       VALUE 'Alisha'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000475942.
               10  FILLER          PIC X(12)       VALUE 'Alison'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001506047.
               10  FILLER          PIC X(12)       VALUE 'Allison'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003740866.
               10  FILLER          PIC X(12)       VALUE 'Alyssa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003243410.
               10  FILLER          PIC X(12)       VALUE 'Amanda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.015360768.
               10  FILLER          PIC X(12)       VALUE 'Amber'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006928794.
               10  FILLER          PIC X(12)       VALUE 'Amy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.012860314.
               10  FILLER          PIC X(12)       VALUE 'Ana'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000853679.
               10  FILLER          PIC X(12)       VALUE 'Andrea'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006747028.
               10  FILLER          PIC X(12)       VALUE 'Angel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001161117.
               10  FILLER          PIC X(12)       VALUE 'Angela'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.011954085.
               10  FILLER          PIC X(12)       VALUE 'Angelica'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001102746.
               10  FILLER          PIC X(12)       VALUE 'Angie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000301660.
               10  FILLER          PIC X(12)       VALUE 'Anita'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001383767.
               10  FILLER          PIC X(12)       VALUE 'Ann'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002627483.
               10  FILLER          PIC X(12)       VALUE 'Anna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004691502.
               10  FILLER          PIC X(12)       VALUE 'Anne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002089582.
               10  FILLER          PIC X(12)       VALUE 'Annette'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001487399.
               10  FILLER          PIC X(12)       VALUE 'Ariana'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000412668.
               10  FILLER          PIC X(12)       VALUE 'Ariel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000615774.
               10  FILLER          PIC X(12)       VALUE 'Ashlee'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000696534.
               10  FILLER          PIC X(12)       VALUE 'Ashley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014773009.
               10  FILLER          PIC X(12)       VALUE 'Audrey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001139165.
               10  FILLER          PIC X(12)       VALUE 'Autumn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000918594.
               10  FILLER          PIC X(12)       VALUE 'Bailey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000691916.
               10  FILLER          PIC X(12)       VALUE 'Barbara'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004839169.
               10  FILLER          PIC X(12)       VALUE 'Becky'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000960944.
               10  FILLER          PIC X(12)       VALUE 'Belinda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000502227.
               10  FILLER          PIC X(12)       VALUE 'Beth'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002246113.
               10  FILLER          PIC X(12)       VALUE 'Bethany'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001249385.
               10  FILLER          PIC X(12)       VALUE 'Betty'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000840241.
               10  FILLER          PIC X(12)       VALUE 'Beverly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000990272.
               10  FILLER          PIC X(12)       VALUE 'Bianca'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000624835.
               10  FILLER          PIC X(12)       VALUE 'Bonnie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001351901.
               10  FILLER          PIC X(12)       VALUE 'Brandi'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002077216.
               10  FILLER          PIC X(12)       VALUE 'Brandy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002177499.
               10  FILLER          PIC X(12)       VALUE 'Breanna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000876003.
               10  FILLER          PIC X(12)       VALUE 'Brenda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005737124.
               10  FILLER          PIC X(12)       VALUE 'Briana'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000936650.
               10  FILLER          PIC X(12)       VALUE 'Brianna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002543549.
               10  FILLER          PIC X(12)       VALUE 'Bridget'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000787232.
               10  FILLER          PIC X(12)       VALUE 'Brittany'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007258404.
               10  FILLER          PIC X(12)       VALUE 'Brittney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001566147.
               10  FILLER          PIC X(12)       VALUE 'Brooke'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002410152.
               10  FILLER          PIC X(12)       VALUE 'Caitlin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001808319.
               10  FILLER          PIC X(12)       VALUE 'Caitlyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000481194.
               10  FILLER          PIC X(12)       VALUE 'Candace'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000550662.
               10  FILLER          PIC X(12)       VALUE 'Candice'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000653199.
               10  FILLER          PIC X(12)       VALUE 'Carla'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001951850.
               10  FILLER          PIC X(12)       VALUE 'Carly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000498725.
               10  FILLER          PIC X(12)       VALUE 'Carmen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000891783.
               10  FILLER          PIC X(12)       VALUE 'Carol'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002972719.
               10  FILLER          PIC X(12)       VALUE 'Caroline'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001198127.
               10  FILLER          PIC X(12)       VALUE 'Carolyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002647225.
               10  FILLER          PIC X(12)       VALUE 'Carrie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002934659.
               10  FILLER          PIC X(12)       VALUE 'Casey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001177707.
               10  FILLER          PIC X(12)       VALUE 'Cassandra'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002501243.
               10  FILLER          PIC X(12)       VALUE 'Cassidy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000452129.
               10  FILLER          PIC X(12)       VALUE 'Cassie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000344886.
               10  FILLER          PIC X(12)       VALUE 'Catherine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004460622.
               10  FILLER          PIC X(12)       VALUE 'Cathy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001413248.
               10  FILLER          PIC X(12)       VALUE 'Charlene'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000538865.
               10  FILLER          PIC X(12)       VALUE 'Charlotte'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000530417.
               10  FILLER          PIC X(12)       VALUE 'Chelsea'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002800430.
               10  FILLER          PIC X(12)       VALUE 'Chelsey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000368501.
               10  FILLER          PIC X(12)       VALUE 'Cheryl'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004166447.
               10  FILLER          PIC X(12)       VALUE 'Cheyenne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000696907.
               10  FILLER          PIC X(12)       VALUE 'Chloe'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000565807.
               10  FILLER          PIC X(12)       VALUE 'Christie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000397873.
               10  FILLER          PIC X(12)       VALUE 'Christina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.008735669.
               10  FILLER          PIC X(12)       VALUE 'Christine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007488758.
               10  FILLER          PIC X(12)       VALUE 'Christy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001418610.
               10  FILLER          PIC X(12)       VALUE 'Cindy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003360109.
               10  FILLER          PIC X(12)       VALUE 'Claire'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000553835.
               10  FILLER          PIC X(12)       VALUE 'Claudia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000960550.
               10  FILLER          PIC X(12)       VALUE 'Colleen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001836203.
               10  FILLER          PIC X(12)       VALUE 'Connie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001821845.
               10  FILLER          PIC X(12)       VALUE 'Courtney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004849390.
               10  FILLER          PIC X(12)       VALUE 'Cristina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000328734.
               10  FILLER          PIC X(12)       VALUE 'Crystal'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006365045.
               10  FILLER          PIC X(12)       VALUE 'Cynthia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007655379.
               10  FILLER          PIC X(12)       VALUE 'Daisy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000437443.
               10  FILLER          PIC X(12)       VALUE 'Dana'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003395805.
               10  FILLER          PIC X(12)       VALUE 'Danielle'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006671783.
               10  FILLER          PIC X(12)       VALUE 'Darlene'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000952737.
               10  FILLER          PIC X(12)       VALUE 'Dawn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005014983.
               10  FILLER          PIC X(12)       VALUE 'Deanna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002049026.
               10  FILLER          PIC X(12)       VALUE 'Debbie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001842922.
               10  FILLER          PIC X(12)       VALUE 'Deborah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005386088.
               10  FILLER          PIC X(12)       VALUE 'Debra'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004123572.
               10  FILLER          PIC X(12)       VALUE 'Denise'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004592291.
               10  FILLER          PIC X(12)       VALUE 'Desiree'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000991497.
               10  FILLER          PIC X(12)       VALUE 'Destiny'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001055515.
               10  FILLER          PIC X(12)       VALUE 'Diamond'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000331732.
               10  FILLER          PIC X(12)       VALUE 'Diana'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003699348.
               10  FILLER          PIC X(12)       VALUE 'Diane'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003058996.
               10  FILLER          PIC X(12)       VALUE 'Dominique'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000847857.
               10  FILLER          PIC X(12)       VALUE 'Donna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005708190.
               10  FILLER          PIC X(12)       VALUE 'Doris'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000398026.
               10  FILLER          PIC X(12)       VALUE 'Dorothy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000722426.
               10  FILLER          PIC X(12)       VALUE 'Ebony'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000399624.
               10  FILLER          PIC X(12)       VALUE 'Eileen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000544271.
               10  FILLER          PIC X(12)       VALUE 'Elaine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000601175.
               10  FILLER          PIC X(12)       VALUE 'Elizabeth'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014954075.
               10  FILLER          PIC X(12)       VALUE 'Ellen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000747267.
               10  FILLER          PIC X(12)       VALUE 'Emily'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.009100581.
               10  FILLER          PIC X(12)       VALUE 'Emma'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001272059.
               10  FILLER          PIC X(12)       VALUE 'Erica'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004344471.
               10  FILLER          PIC X(12)       VALUE 'Erika'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002105537.
               10  FILLER          PIC X(12)       VALUE 'Erin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005450719.
               10  FILLER          PIC X(12)       VALUE 'Evelyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000825095.
               10  FILLER          PIC X(12)       VALUE 'Faith'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000427113.
               10  FILLER          PIC X(12)       VALUE 'Felicia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001717294.
               10  FILLER          PIC X(12)       VALUE 'Frances'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000546897.
               10  FILLER          PIC X(12)       VALUE 'Gabriela'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000526937.
               10  FILLER          PIC X(12)       VALUE 'Gabriella'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000441230.
               10  FILLER          PIC X(12)       VALUE 'Gabrielle'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001090096.
               10  FILLER          PIC X(12)       VALUE 'Gail'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000719340.
               10  FILLER          PIC X(12)       VALUE 'Gina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002841095.
               10  FILLER          PIC X(12)       VALUE 'Glenda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000384982.
               10  FILLER          PIC X(12)       VALUE 'Gloria'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001155623.
               10  FILLER          PIC X(12)       VALUE 'Grace'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000872020.
               10  FILLER          PIC X(12)       VALUE 'Gwendolyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000407831.
               10  FILLER          PIC X(12)       VALUE 'Hailey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000662917.
               10  FILLER          PIC X(12)       VALUE 'Haley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001557939.
               10  FILLER          PIC X(12)       VALUE 'Hannah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004189822.
               10  FILLER          PIC X(12)       VALUE 'Hayley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000478305.
               10  FILLER          PIC X(12)       VALUE 'Heather'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010945254.
               10  FILLER          PIC X(12)       VALUE 'Heidi'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002239941.
               10  FILLER          PIC X(12)       VALUE 'Helen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000636675.
               10  FILLER          PIC X(12)       VALUE 'Holly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003487028.
               10  FILLER          PIC X(12)       VALUE 'Isabel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000352305.
               10  FILLER          PIC X(12)       VALUE 'Isabella'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000410282.
               10  FILLER          PIC X(12)       VALUE 'Jackie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000566748.
               10  FILLER          PIC X(12)       VALUE 'Jaclyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000477080.
               10  FILLER          PIC X(12)       VALUE 'Jacqueline'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004811242.
               10  FILLER          PIC X(12)       VALUE 'Jade'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000446264.
               10  FILLER          PIC X(12)       VALUE 'Jaime'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000853175.
               10  FILLER          PIC X(12)       VALUE 'Jamie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005067663.
               10  FILLER          PIC X(12)       VALUE 'Jane'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000948600.
               10  FILLER          PIC X(12)       VALUE 'Janet'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002489993.
               10  FILLER          PIC X(12)       VALUE 'Janice'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001593308.
               10  FILLER          PIC X(12)       VALUE 'Jasmin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000333374.
               10  FILLER          PIC X(12)       VALUE 'Jasmine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003025422.
               10  FILLER          PIC X(12)       VALUE 'Jean'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000815969.
               10  FILLER          PIC X(12)       VALUE 'Jeanette'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000767293.
               10  FILLER          PIC X(12)       VALUE 'Jeanne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000515381.
               10  FILLER          PIC X(12)       VALUE 'Jenna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001804052.
               10  FILLER          PIC X(12)       VALUE 'Jennifer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.029218839.
               10  FILLER          PIC X(12)       VALUE 'Jenny'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000932667.
               10  FILLER          PIC X(12)       VALUE 'Jessica'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.020047608.
               10  FILLER          PIC X(12)       VALUE 'Jill'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003253018.
               10  FILLER          PIC X(12)       VALUE 'Jillian'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000988587.
               10  FILLER          PIC X(12)       VALUE 'Jo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000442083.
               10  FILLER          PIC X(12)       VALUE 'Joan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000802793.
               10  FILLER          PIC X(12)       VALUE 'Joann'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000544336.
               10  FILLER          PIC X(12)       VALUE 'Joanna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001176284.
               10  FILLER          PIC X(12)       VALUE 'Joanne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000729824.
               10  FILLER          PIC X(12)       VALUE 'Jocelyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000456878.
               10  FILLER          PIC X(12)       VALUE 'Jodi'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001252405.
               10  FILLER          PIC X(12)       VALUE 'Jody'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000741861.
               10  FILLER          PIC X(12)       VALUE 'Jordan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001653057.
               10  FILLER          PIC X(12)       VALUE 'Joy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000916515.
               10  FILLER          PIC X(12)       VALUE 'Joyce'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001009488.
               10  FILLER          PIC X(12)       VALUE 'Judith'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000870706.
               10  FILLER          PIC X(12)       VALUE 'Judy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001101586.
               10  FILLER          PIC X(12)       VALUE 'Julia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003301891.
               10  FILLER          PIC X(12)       VALUE 'Julie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.008211731.
               10  FILLER          PIC X(12)       VALUE 'Kaitlin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000674473.
               10  FILLER          PIC X(12)       VALUE 'Kaitlyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001478623.
               10  FILLER          PIC X(12)       VALUE 'Kara'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001549119.
               10  FILLER          PIC X(12)       VALUE 'Karen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.009643845.
               10  FILLER          PIC X(12)       VALUE 'Kari'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000794323.
               10  FILLER          PIC X(12)       VALUE 'Karina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000494764.
               10  FILLER          PIC X(12)       VALUE 'Karla'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000387696.
               10  FILLER          PIC X(12)       VALUE 'Katelyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001476128.
               10  FILLER          PIC X(12)       VALUE 'Katherine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006581479.
               10  FILLER          PIC X(12)       VALUE 'Kathleen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005035490.
               10  FILLER          PIC X(12)       VALUE 'Kathryn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004177806.
               10  FILLER          PIC X(12)       VALUE 'Kathy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002710214.
               10  FILLER          PIC X(12)       VALUE 'Katie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003056216.
               10  FILLER          PIC X(12)       VALUE 'Katrina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001565446.
               10  FILLER          PIC X(12)       VALUE 'Kayla'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004621465.
               10  FILLER          PIC X(12)       VALUE 'Kaylee'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000551734.
               10  FILLER          PIC X(12)       VALUE 'Kelli'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000932163.
               10  FILLER          PIC X(12)       VALUE 'Kellie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000299187.
               10  FILLER          PIC X(12)       VALUE 'Kelly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.009342929.
               10  FILLER          PIC X(12)       VALUE 'Kelsey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002470383.
               10  FILLER          PIC X(12)       VALUE 'Kendra'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001401079.
               10  FILLER          PIC X(12)       VALUE 'Kerri'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000316215.
               10  FILLER          PIC X(12)       VALUE 'Kerry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000352984.
               10  FILLER          PIC X(12)       VALUE 'Kiara'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000390037.
               10  FILLER          PIC X(12)       VALUE 'Kim'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002518642.
               10  FILLER          PIC X(12)       VALUE 'Kimberly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.015594077.
               10  FILLER          PIC X(12)       VALUE 'Kirsten'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000369486.
               10  FILLER          PIC X(12)       VALUE 'Krista'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001266872.
               10  FILLER          PIC X(12)       VALUE 'Kristen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004345587.
               10  FILLER          PIC X(12)       VALUE 'Kristi'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001022926.
               10  FILLER          PIC X(12)       VALUE 'Kristie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000380189.
               10  FILLER          PIC X(12)       VALUE 'Kristin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003613728.
               10  FILLER          PIC X(12)       VALUE 'Kristina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002316281.
               10  FILLER          PIC X(12)       VALUE 'Kristine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000977709.
               10  FILLER          PIC X(12)       VALUE 'Kristy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001097734.
               10  FILLER          PIC X(12)       VALUE 'Krystal'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001238113.
               10  FILLER          PIC X(12)       VALUE 'Kylie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000497390.
               10  FILLER          PIC X(12)       VALUE 'Lacey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000454690.
               10  FILLER          PIC X(12)       VALUE 'Latasha'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000329040.
               10  FILLER          PIC X(12)       VALUE 'Latoya'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000646371.
               10  FILLER          PIC X(12)       VALUE 'Laura'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010815096.
               10  FILLER          PIC X(12)       VALUE 'Lauren'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007015421.
               10  FILLER          PIC X(12)       VALUE 'Laurie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002200786.
               10  FILLER          PIC X(12)       VALUE 'Leah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001997571.
               10  FILLER          PIC X(12)       VALUE 'Leslie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003606134.
               10  FILLER          PIC X(12)       VALUE 'Linda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006437751.
               10  FILLER          PIC X(12)       VALUE 'Lindsay'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002185466.
               10  FILLER          PIC X(12)       VALUE 'Lindsey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002646153.
               10  FILLER          PIC X(12)       VALUE 'Lisa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.018727290.
               10  FILLER          PIC X(12)       VALUE 'Loretta'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000482945.
               10  FILLER          PIC X(12)       VALUE 'Lori'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006040316.
               10  FILLER          PIC X(12)       VALUE 'Lorraine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000486753.
               10  FILLER          PIC X(12)       VALUE 'Lydia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000370274.
               10  FILLER          PIC X(12)       VALUE 'Lynn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001522308.
               10  FILLER          PIC X(12)       VALUE 'Mackenzie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000761056.
               10  FILLER          PIC X(12)       VALUE 'Madeline'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000808921.
               10  FILLER          PIC X(12)       VALUE 'Madison'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002011184.
               10  FILLER          PIC X(12)       VALUE 'Makayla'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000439391.
               10  FILLER          PIC X(12)       VALUE 'Mallory'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000688633.
               10  FILLER          PIC X(12)       VALUE 'Mandy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000355566.
               10  FILLER          PIC X(12)       VALUE 'Marcia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000403213.
               10  FILLER          PIC X(12)       VALUE 'Margaret'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003839968.
               10  FILLER          PIC X(12)       VALUE 'Maria'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006593123.
               10  FILLER          PIC X(12)       VALUE 'Mariah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000975980.
               10  FILLER          PIC X(12)       VALUE 'Marie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001520229.
               10  FILLER          PIC X(12)       VALUE 'Marilyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000590889.
               10  FILLER          PIC X(12)       VALUE 'Marisa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000339983.
               10  FILLER          PIC X(12)       VALUE 'Marissa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001582627.
               10  FILLER          PIC X(12)       VALUE 'Martha'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001290028.
               10  FILLER          PIC X(12)       VALUE 'Mary'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014288466.
               10  FILLER          PIC X(12)       VALUE 'Maureen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000753855.
               10  FILLER          PIC X(12)       VALUE 'Mckenzie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000334512.
               10  FILLER          PIC X(12)       VALUE 'Meagan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000729999.
               10  FILLER          PIC X(12)       VALUE 'Megan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007686786.
               10  FILLER          PIC X(12)       VALUE 'Meghan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001481578.
               10  FILLER          PIC X(12)       VALUE 'Melanie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003400117.
               10  FILLER          PIC X(12)       VALUE 'Melinda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002078113.
               10  FILLER          PIC X(12)       VALUE 'Melissa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014890692.
               10  FILLER          PIC X(12)       VALUE 'Melody'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000404264.
               10  FILLER          PIC X(12)       VALUE 'Mercedes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000334643.
               10  FILLER          PIC X(12)       VALUE 'Meredith'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000766987.
               10  FILLER          PIC X(12)       VALUE 'Mia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000319935.
               10  FILLER          PIC X(12)       VALUE 'Michaela'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000506998.
               10  FILLER          PIC X(12)       VALUE 'Michele'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003519551.
               10  FILLER          PIC X(12)       VALUE 'Michelle'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.015274230.
               10  FILLER          PIC X(12)       VALUE 'Mikayla'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000410195.
               10  FILLER          PIC X(12)       VALUE 'Mindy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000306891.
               10  FILLER          PIC X(12)       VALUE 'Miranda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001421193.
               10  FILLER          PIC X(12)       VALUE 'Misty'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001564614.
               10  FILLER          PIC X(12)       VALUE 'Molly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001710641.
               10  FILLER          PIC X(12)       VALUE 'Monica'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004324095.
               10  FILLER          PIC X(12)       VALUE 'Monique'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001272125.
               10  FILLER          PIC X(12)       VALUE 'Morgan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002527025.
               10  FILLER          PIC X(12)       VALUE 'Nancy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005023343.
               10  FILLER          PIC X(12)       VALUE 'Natalie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003658398.
               10  FILLER          PIC X(12)       VALUE 'Natasha'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001739815.
               10  FILLER          PIC X(12)       VALUE 'Nichole'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001001237.
               10  FILLER          PIC X(12)       VALUE 'Nicole'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.011156655.
               10  FILLER          PIC X(12)       VALUE 'Nina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000298115.
               10  FILLER          PIC X(12)       VALUE 'Norma'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000470754.
               10  FILLER          PIC X(12)       VALUE 'Olivia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001967609.
               10  FILLER          PIC X(12)       VALUE 'Paige'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001106313.
               10  FILLER          PIC X(12)       VALUE 'Pam'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000374454.
               10  FILLER          PIC X(12)       VALUE 'Pamela'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005816222.
               10  FILLER          PIC X(12)       VALUE 'Patricia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.008349353.
               10  FILLER          PIC X(12)       VALUE 'Patty'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000383493.
               10  FILLER          PIC X(12)       VALUE 'Paula'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002478284.
               10  FILLER          PIC X(12)       VALUE 'Peggy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000810606.
               10  FILLER          PIC X(12)       VALUE 'Penny'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000836564.
               10  FILLER          PIC X(12)       VALUE 'Phyllis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000562437.
               10  FILLER          PIC X(12)       VALUE 'Priscilla'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000350226.
               10  FILLER          PIC X(12)       VALUE 'Rachael'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001098128.
               10  FILLER          PIC X(12)       VALUE 'Rachel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.008761080.
               10  FILLER          PIC X(12)       VALUE 'Raven'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000404855.
               10  FILLER          PIC X(12)       VALUE 'Rebecca'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010563161.
               10  FILLER          PIC X(12)       VALUE 'Rebekah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000858581.
               10  FILLER          PIC X(12)       VALUE 'Regina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001941739.
               10  FILLER          PIC X(12)       VALUE 'Renee'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002578830.
               10  FILLER          PIC X(12)       VALUE 'Rhonda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002879221.
               10  FILLER          PIC X(12)       VALUE 'Rita'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000719187.
               10  FILLER          PIC X(12)       VALUE 'Roberta'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000461715.
               10  FILLER          PIC X(12)       VALUE 'Robin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004091990.
               10  FILLER          PIC X(12)       VALUE 'Robyn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000321380.
               10  FILLER          PIC X(12)       VALUE 'Rose'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000697125.
               10  FILLER          PIC X(12)       VALUE 'Ruth'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001041946.
               10  FILLER          PIC X(12)       VALUE 'Sabrina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001920969.
               10  FILLER          PIC X(12)       VALUE 'Sally'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000532912.
               10  FILLER          PIC X(12)       VALUE 'Samantha'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.008186124.
               10  FILLER          PIC X(12)       VALUE 'Sandra'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006473426.
               10  FILLER          PIC X(12)       VALUE 'Sandy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000497106.
               10  FILLER          PIC X(12)       VALUE 'Sara'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005619879.
               10  FILLER          PIC X(12)       VALUE 'Sarah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014434273.
               10  FILLER          PIC X(12)       VALUE 'Savannah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000978344.
               10  FILLER          PIC X(12)       VALUE 'Selena'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000329106.
               10  FILLER          PIC X(12)       VALUE 'Shannon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005952552.
               10  FILLER          PIC X(12)       VALUE 'Shari'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000449043.
               10  FILLER          PIC X(12)       VALUE 'Sharon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004796469.
               10  FILLER          PIC X(12)       VALUE 'Shawna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000354209.
               10  FILLER          PIC X(12)       VALUE 'Sheena'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000355763.
               10  FILLER          PIC X(12)       VALUE 'Sheila'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002201290.
               10  FILLER          PIC X(12)       VALUE 'Shelby'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001575601.
               10  FILLER          PIC X(12)       VALUE 'Shelia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000403673.
               10  FILLER          PIC X(12)       VALUE 'Shelley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000922227.
               10  FILLER          PIC X(12)       VALUE 'Shelly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001339469.
               10  FILLER          PIC X(12)       VALUE 'Sheri'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000913166.
               10  FILLER          PIC X(12)       VALUE 'Sherri'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001285038.
               10  FILLER          PIC X(12)       VALUE 'Sherry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002445235.
               10  FILLER          PIC X(12)       VALUE 'Sheryl'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000570250.
               10  FILLER          PIC X(12)       VALUE 'Shirley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000833259.
               10  FILLER          PIC X(12)       VALUE 'Sierra'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000954816.
               10  FILLER          PIC X(12)       VALUE 'Sonia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000332739.
               10  FILLER          PIC X(12)       VALUE 'Sonya'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000914085.
               10  FILLER          PIC X(12)       VALUE 'Sophia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000535976.
               10  FILLER          PIC X(12)       VALUE 'Stacey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002836761.
               10  FILLER          PIC X(12)       VALUE 'Stacie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000390300.
               10  FILLER          PIC X(12)       VALUE 'Stacy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003117170.
               10  FILLER          PIC X(12)       VALUE 'Stefanie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000346440.
               10  FILLER          PIC X(12)       VALUE 'Stephanie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.013595762.
               10  FILLER          PIC X(12)       VALUE 'Sue'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000472877.
               10  FILLER          PIC X(12)       VALUE 'Summer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000411508.
               10  FILLER          PIC X(12)       VALUE 'Susan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.008897300.
               10  FILLER          PIC X(12)       VALUE 'Suzanne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001943577.
               10  FILLER          PIC X(12)       VALUE 'Sydney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001220101.
               10  FILLER          PIC X(12)       VALUE 'Sylvia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000625798.
               10  FILLER          PIC X(12)       VALUE 'Tabitha'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000428404.
               10  FILLER          PIC X(12)       VALUE 'Tamara'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002129480.
               10  FILLER          PIC X(12)       VALUE 'Tami'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000403651.
               10  FILLER          PIC X(12)       VALUE 'Tammie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000423370.
               10  FILLER          PIC X(12)       VALUE 'Tammy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006493584.
               10  FILLER          PIC X(12)       VALUE 'Tanya'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002039024.
               10  FILLER          PIC X(12)       VALUE 'Tara'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003168340.
               10  FILLER          PIC X(12)       VALUE 'Tasha'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000355807.
               10  FILLER          PIC X(12)       VALUE 'Taylor'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003996871.
               10  FILLER          PIC X(12)       VALUE 'Teresa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005060003.
               10  FILLER          PIC X(12)       VALUE 'Terri'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001823903.
               10  FILLER          PIC X(12)       VALUE 'Terry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000604940.
               10  FILLER          PIC X(12)       VALUE 'Theresa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003492762.
               10  FILLER          PIC X(12)       VALUE 'Tiffany'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006594283.
               10  FILLER          PIC X(12)       VALUE 'Tina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005186419.
               10  FILLER          PIC X(12)       VALUE 'Toni'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000891695.
               10  FILLER          PIC X(12)       VALUE 'Tonya'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002404133.
               10  FILLER          PIC X(12)       VALUE 'Tracey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001511146.
               10  FILLER          PIC X(12)       VALUE 'Traci'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000861930.
               10  FILLER          PIC X(12)       VALUE 'Tracie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000301901.
               10  FILLER          PIC X(12)       VALUE 'Tracy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004985720.
               10  FILLER          PIC X(12)       VALUE 'Tricia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000449196.
               10  FILLER          PIC X(12)       VALUE 'Valerie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003218022.
               10  FILLER          PIC X(12)       VALUE 'Vanessa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003779189.
               10  FILLER          PIC X(12)       VALUE 'Veronica'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003017805.
               10  FILLER          PIC X(12)       VALUE 'Vicki'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000886530.
               10  FILLER          PIC X(12)       VALUE 'Vickie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000695199.
               10  FILLER          PIC X(12)       VALUE 'Victoria'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005237677.
               10  FILLER          PIC X(12)       VALUE 'Virginia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001496482.
               10  FILLER          PIC X(12)       VALUE 'Wanda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001336186.
               10  FILLER          PIC X(12)       VALUE 'Wendy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004058263.
               10  FILLER          PIC X(12)       VALUE 'Whitney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001690768.
               10  FILLER          PIC X(12)       VALUE 'Yesenia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000331951.
               10  FILLER          PIC X(12)       VALUE 'Yolanda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001213819.
               10  FILLER          PIC X(12)       VALUE 'Yvette'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000483427.
               10  FILLER          PIC X(12)       VALUE 'Yvonne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001005483.
               10  FILLER          PIC X(12)       VALUE 'Zoe'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000367407.
           05  FILLER REDEFINES FIRST-NAME-FEMALE-OCCS.
               10  FILLER                          OCCURS 381
                                                   INDEXED FNF-DX.
                   15  FIRST-NAME-FEMALE 
                                   PIC X(12).
                   15  FIRST-NAME-FEMALE-WEIGHT
                                   PIC SV9(9) COMP.

       01  FIRST-NAMES-MALE.
           05  FIRST-NAME-MALE-CNT
                                   PIC S9(4)  COMP VALUE 322.
           05  FIRST-NAME-MALE-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  FIRST-NAME-MALE-OCCS.
               10  FILLER          PIC X(12)       VALUE 'Aaron'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006741589.
               10  FILLER          PIC X(12)       VALUE 'Adam'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007124922.
               10  FILLER          PIC X(12)       VALUE 'Adrian'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001521889.
               10  FILLER          PIC X(12)       VALUE 'Alan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002344657.
               10  FILLER          PIC X(12)       VALUE 'Albert'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001316595.
               10  FILLER          PIC X(12)       VALUE 'Alec'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000442958.
               10  FILLER          PIC X(12)       VALUE 'Alejandro'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000862489.
               10  FILLER          PIC X(12)       VALUE 'Alex'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002111833.
               10  FILLER          PIC X(12)       VALUE 'Alexander'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005215733.
               10  FILLER          PIC X(12)       VALUE 'Alexis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000277915.
               10  FILLER          PIC X(12)       VALUE 'Alfred'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000318919.
               10  FILLER          PIC X(12)       VALUE 'Allen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001679613.
               10  FILLER          PIC X(12)       VALUE 'Alvin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000247940.
               10  FILLER          PIC X(12)       VALUE 'Andre'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001400621.
               10  FILLER          PIC X(12)       VALUE 'Andres'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000335574.
               10  FILLER          PIC X(12)       VALUE 'Andrew'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.013475074.
               10  FILLER          PIC X(12)       VALUE 'Angel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000902262.
               10  FILLER          PIC X(12)       VALUE 'Anthony'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.013783357.
               10  FILLER          PIC X(12)       VALUE 'Antonio'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002392535.
               10  FILLER          PIC X(12)       VALUE 'Arthur'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001342637.
               10  FILLER          PIC X(12)       VALUE 'Austin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003785615.
               10  FILLER          PIC X(12)       VALUE 'Barry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001102751.
               10  FILLER          PIC X(12)       VALUE 'Benjamin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006535474.
               10  FILLER          PIC X(12)       VALUE 'Bernard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000298691.
               10  FILLER          PIC X(12)       VALUE 'Bill'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000430013.
               10  FILLER          PIC X(12)       VALUE 'Billy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001749806.
               10  FILLER          PIC X(12)       VALUE 'Blake'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001218155.
               10  FILLER          PIC X(12)       VALUE 'Bob'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000235731.
               10  FILLER          PIC X(12)       VALUE 'Bobby'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001666977.
               10  FILLER          PIC X(12)       VALUE 'Brad'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000984544.
               10  FILLER          PIC X(12)       VALUE 'Bradley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003845018.
               10  FILLER          PIC X(12)       VALUE 'Brady'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000277522.
               10  FILLER          PIC X(12)       VALUE 'Brandon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.009518346.
               10  FILLER          PIC X(12)       VALUE 'Brendan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000736758.
               10  FILLER          PIC X(12)       VALUE 'Brent'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001889131.
               10  FILLER          PIC X(12)       VALUE 'Brett'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002248371.
               10  FILLER          PIC X(12)       VALUE 'Brian'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.015976770.
               10  FILLER          PIC X(12)       VALUE 'Bruce'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001883335.
               10  FILLER          PIC X(12)       VALUE 'Bryan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004564540.
               10  FILLER          PIC X(12)       VALUE 'Bryce'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000457406.
               10  FILLER          PIC X(12)       VALUE 'Caleb'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001485861.
               10  FILLER          PIC X(12)       VALUE 'Calvin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001168738.
               10  FILLER          PIC X(12)       VALUE 'Cameron'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001807550.
               10  FILLER          PIC X(12)       VALUE 'Carl'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002011802.
               10  FILLER          PIC X(12)       VALUE 'Carlos'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002666380.
               10  FILLER          PIC X(12)       VALUE 'Casey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001440035.
               10  FILLER          PIC X(12)       VALUE 'Cesar'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000304898.
               10  FILLER          PIC X(12)       VALUE 'Chad'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003858817.
               10  FILLER          PIC X(12)       VALUE 'Charles'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010889881.
               10  FILLER          PIC X(12)       VALUE 'Chase'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000971942.
               10  FILLER          PIC X(12)       VALUE 'Chris'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001389507.
               10  FILLER          PIC X(12)       VALUE 'Christian'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003097779.
               10  FILLER          PIC X(12)       VALUE 'Christopher'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.027835960.
               10  FILLER          PIC X(12)       VALUE 'Clarence'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000299289.
               10  FILLER          PIC X(12)       VALUE 'Clayton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000662222.
               10  FILLER          PIC X(12)       VALUE 'Clifford'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000530780.
               10  FILLER          PIC X(12)       VALUE 'Clinton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000579307.
               10  FILLER          PIC X(12)       VALUE 'Cody'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003534820.
               10  FILLER          PIC X(12)       VALUE 'Cole'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000578811.
               10  FILLER          PIC X(12)       VALUE 'Colin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000785080.
               10  FILLER          PIC X(12)       VALUE 'Collin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000406057.
               10  FILLER          PIC X(12)       VALUE 'Colton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000520845.
               10  FILLER          PIC X(12)       VALUE 'Connor'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000981073.
               10  FILLER          PIC X(12)       VALUE 'Corey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002476612.
               10  FILLER          PIC X(12)       VALUE 'Cory'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001813005.
               10  FILLER          PIC X(12)       VALUE 'Craig'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003381610.
               10  FILLER          PIC X(12)       VALUE 'Cristian'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000333847.
               10  FILLER          PIC X(12)       VALUE 'Curtis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002140235.
               10  FILLER          PIC X(12)       VALUE 'Dakota'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000797614.
               10  FILLER          PIC X(12)       VALUE 'Dale'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001171354.
               10  FILLER          PIC X(12)       VALUE 'Dalton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000615113.
               10  FILLER          PIC X(12)       VALUE 'Damon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000343080.
               10  FILLER          PIC X(12)       VALUE 'Dan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000388496.
               10  FILLER          PIC X(12)       VALUE 'Daniel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.018881874.
               10  FILLER          PIC X(12)       VALUE 'Danny'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001873879.
               10  FILLER          PIC X(12)       VALUE 'Darin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000234962.
               10  FILLER          PIC X(12)       VALUE 'Darius'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000336189.
               10  FILLER          PIC X(12)       VALUE 'Darrell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001218582.
               10  FILLER          PIC X(12)       VALUE 'Darren'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001253738.
               10  FILLER          PIC X(12)       VALUE 'Darryl'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000670190.
               10  FILLER          PIC X(12)       VALUE 'Daryl'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000260918.
               10  FILLER          PIC X(12)       VALUE 'Dave'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000269673.
               10  FILLER          PIC X(12)       VALUE 'David'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.031073833.
               10  FILLER          PIC X(12)       VALUE 'Dean'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000965375.
               10  FILLER          PIC X(12)       VALUE 'Dennis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003318992.
               10  FILLER          PIC X(12)       VALUE 'Derek'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003095299.
               10  FILLER          PIC X(12)       VALUE 'Derrick'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001955921.
               10  FILLER          PIC X(12)       VALUE 'Devin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001312474.
               10  FILLER          PIC X(12)       VALUE 'Devon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000485877.
               10  FILLER          PIC X(12)       VALUE 'Dillon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000558361.
               10  FILLER          PIC X(12)       VALUE 'Dominic'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000438221.
               10  FILLER          PIC X(12)       VALUE 'Don'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000378322.
               10  FILLER          PIC X(12)       VALUE 'Donald'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005689572.
               10  FILLER          PIC X(12)       VALUE 'Douglas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004513687.
               10  FILLER          PIC X(12)       VALUE 'Drew'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000596868.
               10  FILLER          PIC X(12)       VALUE 'Duane'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000618550.
               10  FILLER          PIC X(12)       VALUE 'Dustin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003088938.
               10  FILLER          PIC X(12)       VALUE 'Dwayne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000711382.
               10  FILLER          PIC X(12)       VALUE 'Dylan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002329096.
               10  FILLER          PIC X(12)       VALUE 'Earl'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000348347.
               10  FILLER          PIC X(12)       VALUE 'Eddie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000794400.
               10  FILLER          PIC X(12)       VALUE 'Edgar'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000379536.
               10  FILLER          PIC X(12)       VALUE 'Eduardo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000465358.
               10  FILLER          PIC X(12)       VALUE 'Edward'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005702242.
               10  FILLER          PIC X(12)       VALUE 'Edwin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001117833.
               10  FILLER          PIC X(12)       VALUE 'Elijah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000592183.
               10  FILLER          PIC X(12)       VALUE 'Eric'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.012024659.
               10  FILLER          PIC X(12)       VALUE 'Erik'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001997096.
               10  FILLER          PIC X(12)       VALUE 'Ernest'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000746556.
               10  FILLER          PIC X(12)       VALUE 'Ethan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001143978.
               10  FILLER          PIC X(12)       VALUE 'Eugene'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000784243.
               10  FILLER          PIC X(12)       VALUE 'Evan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001570691.
               10  FILLER          PIC X(12)       VALUE 'Fernando'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000557608.
               10  FILLER          PIC X(12)       VALUE 'Francis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000330837.
               10  FILLER          PIC X(12)       VALUE 'Francisco'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001084335.
               10  FILLER          PIC X(12)       VALUE 'Frank'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003276449.
               10  FILLER          PIC X(12)       VALUE 'Franklin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000237561.
               10  FILLER          PIC X(12)       VALUE 'Fred'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000396618.
               10  FILLER          PIC X(12)       VALUE 'Frederick'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001104188.
               10  FILLER          PIC X(12)       VALUE 'Gabriel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001906504.
               10  FILLER          PIC X(12)       VALUE 'Garrett'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001124861.
               10  FILLER          PIC X(12)       VALUE 'Gary'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005023109.
               10  FILLER          PIC X(12)       VALUE 'Gavin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000295373.
               10  FILLER          PIC X(12)       VALUE 'Gene'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000234260.
               10  FILLER          PIC X(12)       VALUE 'Geoffrey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000425978.
               10  FILLER          PIC X(12)       VALUE 'George'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004423984.
               10  FILLER          PIC X(12)       VALUE 'Gerald'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001658410.
               10  FILLER          PIC X(12)       VALUE 'Gilbert'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000246726.
               10  FILLER          PIC X(12)       VALUE 'Glen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000374338.
               10  FILLER          PIC X(12)       VALUE 'Glenn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001111421.
               10  FILLER          PIC X(12)       VALUE 'Gordon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000270750.
               10  FILLER          PIC X(12)       VALUE 'Grant'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000683220.
               10  FILLER          PIC X(12)       VALUE 'Greg'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000623492.
               10  FILLER          PIC X(12)       VALUE 'Gregg'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000235885.
               10  FILLER          PIC X(12)       VALUE 'Gregory'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007676443.
               10  FILLER          PIC X(12)       VALUE 'Guy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000262645.
               10  FILLER          PIC X(12)       VALUE 'Harold'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000929467.
               10  FILLER          PIC X(12)       VALUE 'Harry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000586934.
               10  FILLER          PIC X(12)       VALUE 'Hayden'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000279454.
               10  FILLER          PIC X(12)       VALUE 'Hector'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000798691.
               10  FILLER          PIC X(12)       VALUE 'Henry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001856232.
               10  FILLER          PIC X(12)       VALUE 'Herbert'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000234226.
               10  FILLER          PIC X(12)       VALUE 'Howard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000712921.
               10  FILLER          PIC X(12)       VALUE 'Hunter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001034679.
               10  FILLER          PIC X(12)       VALUE 'Ian'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001863192.
               10  FILLER          PIC X(12)       VALUE 'Isaac'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001001951.
               10  FILLER          PIC X(12)       VALUE 'Isaiah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000625441.
               10  FILLER          PIC X(12)       VALUE 'Ivan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000350433.
               10  FILLER          PIC X(12)       VALUE 'Jack'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001839748.
               10  FILLER          PIC X(12)       VALUE 'Jackson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000403253.
               10  FILLER          PIC X(12)       VALUE 'Jacob'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007845384.
               10  FILLER          PIC X(12)       VALUE 'Jaime'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000421378.
               10  FILLER          PIC X(12)       VALUE 'Jake'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000565782.
               10  FILLER          PIC X(12)       VALUE 'James'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.029601617.
               10  FILLER          PIC X(12)       VALUE 'Jamie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000935520.
               10  FILLER          PIC X(12)       VALUE 'Jared'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002538802.
               10  FILLER          PIC X(12)       VALUE 'Jason'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.015205130.
               10  FILLER          PIC X(12)       VALUE 'Javier'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000625202.
               10  FILLER          PIC X(12)       VALUE 'Jay'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001411462.
               10  FILLER          PIC X(12)       VALUE 'Jeff'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001271436.
               10  FILLER          PIC X(12)       VALUE 'Jeffery'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002627873.
               10  FILLER          PIC X(12)       VALUE 'Jeffrey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.012257090.
               10  FILLER          PIC X(12)       VALUE 'Jeremiah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001209605.
               10  FILLER          PIC X(12)       VALUE 'Jeremy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006336079.
               10  FILLER          PIC X(12)       VALUE 'Jermaine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000450156.
               10  FILLER          PIC X(12)       VALUE 'Jerome'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000634299.
               10  FILLER          PIC X(12)       VALUE 'Jerry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003150273.
               10  FILLER          PIC X(12)       VALUE 'Jesse'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003884552.
               10  FILLER          PIC X(12)       VALUE 'Jesus'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001628965.
               10  FILLER          PIC X(12)       VALUE 'Jim'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000567714.
               10  FILLER          PIC X(12)       VALUE 'Jimmy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001607489.
               10  FILLER          PIC X(12)       VALUE 'Joe'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001621544.
               10  FILLER          PIC X(12)       VALUE 'Joel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002537742.
               10  FILLER          PIC X(12)       VALUE 'John'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.028683008.
               10  FILLER          PIC X(12)       VALUE 'Johnathan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000840448.
               10  FILLER          PIC X(12)       VALUE 'Johnny'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002117065.
               10  FILLER          PIC X(12)       VALUE 'Jon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001561184.
               10  FILLER          PIC X(12)       VALUE 'Jonathan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.009963971.
               10  FILLER          PIC X(12)       VALUE 'Jonathon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000701157.
               10  FILLER          PIC X(12)       VALUE 'Jordan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003451546.
               10  FILLER          PIC X(12)       VALUE 'Jorge'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001180553.
               10  FILLER          PIC X(12)       VALUE 'Jose'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005368207.
               10  FILLER          PIC X(12)       VALUE 'Joseph'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.018604763.
               10  FILLER          PIC X(12)       VALUE 'Joshua'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014808101.
               10  FILLER          PIC X(12)       VALUE 'Juan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003233598.
               10  FILLER          PIC X(12)       VALUE 'Julian'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000693736.
               10  FILLER          PIC X(12)       VALUE 'Justin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010197889.
               10  FILLER          PIC X(12)       VALUE 'Karl'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000362437.
               10  FILLER          PIC X(12)       VALUE 'Keith'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004622866.
               10  FILLER          PIC X(12)       VALUE 'Kelly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000775283.
               10  FILLER          PIC X(12)       VALUE 'Kenneth'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.008318145.
               10  FILLER          PIC X(12)       VALUE 'Kent'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000329418.
               10  FILLER          PIC X(12)       VALUE 'Kerry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000261448.
               10  FILLER          PIC X(12)       VALUE 'Kevin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014324157.
               10  FILLER          PIC X(12)       VALUE 'Kirk'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000380100.
               10  FILLER          PIC X(12)       VALUE 'Kristopher'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000580692.
               10  FILLER          PIC X(12)       VALUE 'Kurt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000716375.
               10  FILLER          PIC X(12)       VALUE 'Kyle'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006350049.
               10  FILLER          PIC X(12)       VALUE 'Lance'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001048495.
               10  FILLER          PIC X(12)       VALUE 'Larry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003658807.
               10  FILLER          PIC X(12)       VALUE 'Lawrence'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001670294.
               10  FILLER          PIC X(12)       VALUE 'Lee'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001223883.
               10  FILLER          PIC X(12)       VALUE 'Leon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000236347.
               10  FILLER          PIC X(12)       VALUE 'Leonard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000756713.
               10  FILLER          PIC X(12)       VALUE 'Leroy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000260234.
               10  FILLER          PIC X(12)       VALUE 'Leslie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000234637.
               10  FILLER          PIC X(12)       VALUE 'Levi'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000347184.
               10  FILLER          PIC X(12)       VALUE 'Logan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001325812.
               10  FILLER          PIC X(12)       VALUE 'Lonnie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000258576.
               10  FILLER          PIC X(12)       VALUE 'Louis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001212255.
               10  FILLER          PIC X(12)       VALUE 'Lucas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001098237.
               10  FILLER          PIC X(12)       VALUE 'Luis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002427777.
               10  FILLER          PIC X(12)       VALUE 'Luke'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001221455.
               10  FILLER          PIC X(12)       VALUE 'Malik'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000306813.
               10  FILLER          PIC X(12)       VALUE 'Manuel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001331369.
               10  FILLER          PIC X(12)       VALUE 'Marc'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001431947.
               10  FILLER          PIC X(12)       VALUE 'Marco'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000290586.
               10  FILLER          PIC X(12)       VALUE 'Marcus'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002604122.
               10  FILLER          PIC X(12)       VALUE 'Mario'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001229337.
               10  FILLER          PIC X(12)       VALUE 'Mark'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014382277.
               10  FILLER          PIC X(12)       VALUE 'Martin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002085226.
               10  FILLER          PIC X(12)       VALUE 'Marvin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000732962.
               10  FILLER          PIC X(12)       VALUE 'Mason'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000562037.
               10  FILLER          PIC X(12)       VALUE 'Mathew'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000605555.
               10  FILLER          PIC X(12)       VALUE 'Matthew'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.020425018.
               10  FILLER          PIC X(12)       VALUE 'Maurice'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000777078.
               10  FILLER          PIC X(12)       VALUE 'Max'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000311276.
               10  FILLER          PIC X(12)       VALUE 'Maxwell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000357478.
               10  FILLER          PIC X(12)       VALUE 'Melvin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000619320.
               10  FILLER          PIC X(12)       VALUE 'Michael'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.045602241.
               10  FILLER          PIC X(12)       VALUE 'Micheal'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001273847.
               10  FILLER          PIC X(12)       VALUE 'Miguel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001416267.
               10  FILLER          PIC X(12)       VALUE 'Mike'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001221797.
               10  FILLER          PIC X(12)       VALUE 'Mitchell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001747788.
               10  FILLER          PIC X(12)       VALUE 'Nathan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005039405.
               10  FILLER          PIC X(12)       VALUE 'Nathaniel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001887558.
               10  FILLER          PIC X(12)       VALUE 'Neil'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000240331.
               10  FILLER          PIC X(12)       VALUE 'Nicholas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010021219.
               10  FILLER          PIC X(12)       VALUE 'Nicolas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000362522.
               10  FILLER          PIC X(12)       VALUE 'Noah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000960947.
               10  FILLER          PIC X(12)       VALUE 'Norman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000389043.
               10  FILLER          PIC X(12)       VALUE 'Omar'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000639052.
               10  FILLER          PIC X(12)       VALUE 'Oscar'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000946583.
               10  FILLER          PIC X(12)       VALUE 'Parker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000277522.
               10  FILLER          PIC X(12)       VALUE 'Patrick'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007153255.
               10  FILLER          PIC X(12)       VALUE 'Paul'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.009272953.
               10  FILLER          PIC X(12)       VALUE 'Pedro'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000275726.
               10  FILLER          PIC X(12)       VALUE 'Perry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000258644.
               10  FILLER          PIC X(12)       VALUE 'Peter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004340385.
               10  FILLER          PIC X(12)       VALUE 'Philip'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002262956.
               10  FILLER          PIC X(12)       VALUE 'Phillip'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002802730.
               10  FILLER          PIC X(12)       VALUE 'Preston'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000292022.
               10  FILLER          PIC X(12)       VALUE 'Ralph'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000836891.
               10  FILLER          PIC X(12)       VALUE 'Randall'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001614722.
               10  FILLER          PIC X(12)       VALUE 'Randy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003021926.
               10  FILLER          PIC X(12)       VALUE 'Ray'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000379451.
               10  FILLER          PIC X(12)       VALUE 'Raymond'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003493952.
               10  FILLER          PIC X(12)       VALUE 'Reginald'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000951080.
               10  FILLER          PIC X(12)       VALUE 'Ricardo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001197276.
               10  FILLER          PIC X(12)       VALUE 'Richard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014131961.
               10  FILLER          PIC X(12)       VALUE 'Rick'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000440016.
               10  FILLER          PIC X(12)       VALUE 'Rickey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000238330.
               10  FILLER          PIC X(12)       VALUE 'Ricky'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001856882.
               10  FILLER          PIC X(12)       VALUE 'Riley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000322031.
               10  FILLER          PIC X(12)       VALUE 'Robert'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.026938092.
               10  FILLER          PIC X(12)       VALUE 'Roberto'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000906024.
               10  FILLER          PIC X(12)       VALUE 'Rodney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002180555.
               10  FILLER          PIC X(12)       VALUE 'Roger'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002038032.
               10  FILLER          PIC X(12)       VALUE 'Ronald'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005767750.
               10  FILLER          PIC X(12)       VALUE 'Ronnie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000905938.
               10  FILLER          PIC X(12)       VALUE 'Ross'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000268630.
               10  FILLER          PIC X(12)       VALUE 'Roy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001311346.
               10  FILLER          PIC X(12)       VALUE 'Ruben'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000774821.
               10  FILLER          PIC X(12)       VALUE 'Russell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002096221.
               10  FILLER          PIC X(12)       VALUE 'Ryan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.011281780.
               10  FILLER          PIC X(12)       VALUE 'Samuel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004980190.
               10  FILLER          PIC X(12)       VALUE 'Scott'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010580999.
               10  FILLER          PIC X(12)       VALUE 'Sean'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005593456.
               10  FILLER          PIC X(12)       VALUE 'Sergio'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000568518.
               10  FILLER          PIC X(12)       VALUE 'Seth'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001537416.
               10  FILLER          PIC X(12)       VALUE 'Shane'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002530218.
               10  FILLER          PIC X(12)       VALUE 'Shannon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000421583.
               10  FILLER          PIC X(12)       VALUE 'Shaun'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000748761.
               10  FILLER          PIC X(12)       VALUE 'Shawn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004474546.
               10  FILLER          PIC X(12)       VALUE 'Spencer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000912094.
               10  FILLER          PIC X(12)       VALUE 'Stanley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000739032.
               10  FILLER          PIC X(12)       VALUE 'Stephen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007675365.
               10  FILLER          PIC X(12)       VALUE 'Steve'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001407564.
               10  FILLER          PIC X(12)       VALUE 'Steven'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.013292898.
               10  FILLER          PIC X(12)       VALUE 'Stuart'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000238826.
               10  FILLER          PIC X(12)       VALUE 'Tanner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000639292.
               10  FILLER          PIC X(12)       VALUE 'Taylor'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001330360.
               10  FILLER          PIC X(12)       VALUE 'Terrance'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000203311.
               10  FILLER          PIC X(12)       VALUE 'Terrence'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000203704.
               10  FILLER          PIC X(12)       VALUE 'Terry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002873624.
               10  FILLER          PIC X(12)       VALUE 'Theodore'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000596561.
               10  FILLER          PIC X(12)       VALUE 'Thomas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014336400.
               10  FILLER          PIC X(12)       VALUE 'Tim'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000711126.
               10  FILLER          PIC X(12)       VALUE 'Timothy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.012632608.
               10  FILLER          PIC X(12)       VALUE 'Todd'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004146120.
               10  FILLER          PIC X(12)       VALUE 'Tom'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000499283.
               10  FILLER          PIC X(12)       VALUE 'Tommy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000778737.
               10  FILLER          PIC X(12)       VALUE 'Tony'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002511563.
               10  FILLER          PIC X(12)       VALUE 'Tracy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000728259.
               10  FILLER          PIC X(12)       VALUE 'Travis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004022458.
               10  FILLER          PIC X(12)       VALUE 'Trevor'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001692523.
               10  FILLER          PIC X(12)       VALUE 'Tristan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000408759.
               10  FILLER          PIC X(12)       VALUE 'Troy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002695415.
               10  FILLER          PIC X(12)       VALUE 'Tyler'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005962323.
               10  FILLER          PIC X(12)       VALUE 'Tyrone'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000587207.
               10  FILLER          PIC X(12)       VALUE 'Vernon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000246401.
               10  FILLER          PIC X(12)       VALUE 'Victor'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002340621.
               10  FILLER          PIC X(12)       VALUE 'Vincent'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002494515.
               10  FILLER          PIC X(12)       VALUE 'Walter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001525891.
               10  FILLER          PIC X(12)       VALUE 'Warren'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000317414.
               10  FILLER          PIC X(12)       VALUE 'Wayne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001609660.
               10  FILLER          PIC X(12)       VALUE 'Wesley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001733835.
               10  FILLER          PIC X(12)       VALUE 'William'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.020025989.
               10  FILLER          PIC X(12)       VALUE 'Willie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001379247.
               10  FILLER          PIC X(12)       VALUE 'Wyatt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000306591.
               10  FILLER          PIC X(12)       VALUE 'Xavier'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000415222.
               10  FILLER          PIC X(12)       VALUE 'Zachary'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005918634.
           05  FILLER REDEFINES FIRST-NAME-MALE-OCCS.
               10  FILLER                          OCCURS 322
                                                   INDEXED FNM-DX.
                   15  FIRST-NAME-MALE 
                                   PIC X(12).
                   15  FIRST-NAME-MALE-WEIGHT
                                   PIC SV9(9) COMP.

      * Top 1000 US surnames from US Census data
      * Weighted by number of occurrences
      * By way of http://names.mongabay.com/data/1000.html on 2/10/2016

       01  LAST-NAMES.
           05  LAST-NAME-CNT       PIC S9(4)  COMP VALUE 1000.
           05  LAST-NAME-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  LAST-NAME-OCCS.
               10  FILLER          PIC X(12)       VALUE 'Smith'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.021712045.
               10  FILLER          PIC X(12)       VALUE 'Johnson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.016969380.
               10  FILLER          PIC X(12)       VALUE 'Williams'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.014016962.
               10  FILLER          PIC X(12)       VALUE 'Brown'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.012610763.
               10  FILLER          PIC X(12)       VALUE 'Jones'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.012451866.
               10  FILLER          PIC X(12)       VALUE 'Miller'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.010305045.
               10  FILLER          PIC X(12)       VALUE 'Davis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.009798219.
               10  FILLER          PIC X(12)       VALUE 'Garcia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007842422.
               10  FILLER          PIC X(12)       VALUE 'Rodriguez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007348561.
               10  FILLER          PIC X(12)       VALUE 'Wilson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007154951.
               10  FILLER          PIC X(12)       VALUE 'Martinez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.007082045.
               10  FILLER          PIC X(12)       VALUE 'Anderson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006966203.
               10  FILLER          PIC X(12)       VALUE 'Taylor'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006582218.
               10  FILLER          PIC X(12)       VALUE 'Thomas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006493824.
               10  FILLER          PIC X(12)       VALUE 'Hernandez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006454314.
               10  FILLER          PIC X(12)       VALUE 'Moore'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006383948.
               10  FILLER          PIC X(12)       VALUE 'Martin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006146745.
               10  FILLER          PIC X(12)       VALUE 'Jackson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.006086567.
               10  FILLER          PIC X(12)       VALUE 'Thompson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005887767.
               10  FILLER          PIC X(12)       VALUE 'White'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005843424.
               10  FILLER          PIC X(12)       VALUE 'Lopez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005679145.
               10  FILLER          PIC X(12)       VALUE 'Lee'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005535909.
               10  FILLER          PIC X(12)       VALUE 'Gonzalez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005461513.
               10  FILLER          PIC X(12)       VALUE 'Harris'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005423356.
               10  FILLER          PIC X(12)       VALUE 'Clark'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005010598.
               10  FILLER          PIC X(12)       VALUE 'Lewis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004659370.
               10  FILLER          PIC X(12)       VALUE 'Robinson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004596305.
               10  FILLER          PIC X(12)       VALUE 'Walker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004580579.
               10  FILLER          PIC X(12)       VALUE 'Perez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004463750.
               10  FILLER          PIC X(12)       VALUE 'Hall'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004327121.
               10  FILLER          PIC X(12)       VALUE 'Young'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004257495.
               10  FILLER          PIC X(12)       VALUE 'Allen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004233920.
               10  FILLER          PIC X(12)       VALUE 'Sanchez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004031749.
               10  FILLER          PIC X(12)       VALUE 'Wright'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004023754.
               10  FILLER          PIC X(12)       VALUE 'King'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004011135.
               10  FILLER          PIC X(12)       VALUE 'Scott'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003838487.
               10  FILLER          PIC X(12)       VALUE 'Green'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003778053.
               10  FILLER          PIC X(12)       VALUE 'Baker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003776901.
               10  FILLER          PIC X(12)       VALUE 'Adams'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003774480.
               10  FILLER          PIC X(12)       VALUE 'Nelson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003766713.
               10  FILLER          PIC X(12)       VALUE 'Hill'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003762455.
               10  FILLER          PIC X(12)       VALUE 'Ramirez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003554281.
               10  FILLER          PIC X(12)       VALUE 'Campbell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003398636.
               10  FILLER          PIC X(12)       VALUE 'Mitchell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003357336.
               10  FILLER          PIC X(12)       VALUE 'Roberts'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003346207.
               10  FILLER          PIC X(12)       VALUE 'Carter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003312700.
               10  FILLER          PIC X(12)       VALUE 'Phillips'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003214932.
               10  FILLER          PIC X(12)       VALUE 'Evans'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003127113.
               10  FILLER          PIC X(12)       VALUE 'Turner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003067045.
               10  FILLER          PIC X(12)       VALUE 'Torres'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002971158.
               10  FILLER          PIC X(12)       VALUE 'Parker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002962725.
               10  FILLER          PIC X(12)       VALUE 'Collins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002904264.
               10  FILLER          PIC X(12)       VALUE 'Edwards'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002897155.
               10  FILLER          PIC X(12)       VALUE 'Stewart'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002859044.
               10  FILLER          PIC X(12)       VALUE 'Flores'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002856449.
               10  FILLER          PIC X(12)       VALUE 'Morris'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002848582.
               10  FILLER          PIC X(12)       VALUE 'Nguyen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002833697.
               10  FILLER          PIC X(12)       VALUE 'Murphy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002745760.
               10  FILLER          PIC X(12)       VALUE 'Rivera'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002736275.
               10  FILLER          PIC X(12)       VALUE 'Cook'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002693623.
               10  FILLER          PIC X(12)       VALUE 'Rogers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002690041.
               10  FILLER          PIC X(12)       VALUE 'Morgan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002525543.
               10  FILLER          PIC X(12)       VALUE 'Peterson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002513125.
               10  FILLER          PIC X(12)       VALUE 'Cooper'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002467950.
               10  FILLER          PIC X(12)       VALUE 'Reed'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002443700.
               10  FILLER          PIC X(12)       VALUE 'Bailey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002429747.
               10  FILLER          PIC X(12)       VALUE 'Bell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002419112.
               10  FILLER          PIC X(12)       VALUE 'Gomez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002408494.
               10  FILLER          PIC X(12)       VALUE 'Kelly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002379209.
               10  FILLER          PIC X(12)       VALUE 'Howard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002327986.
               10  FILLER          PIC X(12)       VALUE 'Ward'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002321973.
               10  FILLER          PIC X(12)       VALUE 'Cox'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002318775.
               10  FILLER          PIC X(12)       VALUE 'Diaz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002300510.
               10  FILLER          PIC X(12)       VALUE 'Richardson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002280051.
               10  FILLER          PIC X(12)       VALUE 'Wood'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002259639.
               10  FILLER          PIC X(12)       VALUE 'Watson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002215168.
               10  FILLER          PIC X(12)       VALUE 'Brooks'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002199808.
               10  FILLER          PIC X(12)       VALUE 'Bennett'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002184311.
               10  FILLER          PIC X(12)       VALUE 'Gray'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002162912.
               10  FILLER          PIC X(12)       VALUE 'James'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002131032.
               10  FILLER          PIC X(12)       VALUE 'Reyes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002124517.
               10  FILLER          PIC X(12)       VALUE 'Cruz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002111304.
               10  FILLER          PIC X(12)       VALUE 'Hughes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002095999.
               10  FILLER          PIC X(12)       VALUE 'Price'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002090206.
               10  FILLER          PIC X(12)       VALUE 'Myers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002054278.
               10  FILLER          PIC X(12)       VALUE 'Long'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002042126.
               10  FILLER          PIC X(12)       VALUE 'Foster'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002019703.
               10  FILLER          PIC X(12)       VALUE 'Sanders'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002018442.
               10  FILLER          PIC X(12)       VALUE 'Ross'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.002009844.
               10  FILLER          PIC X(12)       VALUE 'Morales'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001988655.
               10  FILLER          PIC X(12)       VALUE 'Powell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001978704.
               10  FILLER          PIC X(12)       VALUE 'Sullivan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001970362.
               10  FILLER          PIC X(12)       VALUE 'Russell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001968461.
               10  FILLER          PIC X(12)       VALUE 'Ortiz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001961617.
               10  FILLER          PIC X(12)       VALUE 'Jenkins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001952974.
               10  FILLER          PIC X(12)       VALUE 'Gutierrez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001945371.
               10  FILLER          PIC X(12)       VALUE 'Perry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001942986.
               10  FILLER          PIC X(12)       VALUE 'Butler'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001926859.
               10  FILLER          PIC X(12)       VALUE 'Barnes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001922720.
               10  FILLER          PIC X(12)       VALUE 'Fisher'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001921377.
               10  FILLER          PIC X(12)       VALUE 'Henderson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001919686.
               10  FILLER          PIC X(12)       VALUE 'Coleman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001906255.
               10  FILLER          PIC X(12)       VALUE 'Simmons'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001842531.
               10  FILLER          PIC X(12)       VALUE 'Patterson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001814270.
               10  FILLER          PIC X(12)       VALUE 'Jordan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001801980.
               10  FILLER          PIC X(12)       VALUE 'Reynolds'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001787233.
               10  FILLER          PIC X(12)       VALUE 'Hamilton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001775656.
               10  FILLER          PIC X(12)       VALUE 'Graham'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001773307.
               10  FILLER          PIC X(12)       VALUE 'Kim'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001773243.
               10  FILLER          PIC X(12)       VALUE 'Gonzales'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001772028.
               10  FILLER          PIC X(12)       VALUE 'Alexander'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001767542.
               10  FILLER          PIC X(12)       VALUE 'Ramos'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001764371.
               10  FILLER          PIC X(12)       VALUE 'Wallace'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001743026.
               10  FILLER          PIC X(12)       VALUE 'Griffin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001741893.
               10  FILLER          PIC X(12)       VALUE 'West'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001722047.
               10  FILLER          PIC X(12)       VALUE 'Cole'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001715916.
               10  FILLER          PIC X(12)       VALUE 'Hayes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001712992.
               10  FILLER          PIC X(12)       VALUE 'Chavez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001698299.
               10  FILLER          PIC X(12)       VALUE 'Gibson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001685096.
               10  FILLER          PIC X(12)       VALUE 'Bryant'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001679075.
               10  FILLER          PIC X(12)       VALUE 'Ellis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001662381.
               10  FILLER          PIC X(12)       VALUE 'Stevens'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001657657.
               10  FILLER          PIC X(12)       VALUE 'Murray'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001630218.
               10  FILLER          PIC X(12)       VALUE 'Ford'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001630062.
               10  FILLER          PIC X(12)       VALUE 'Marshall'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001619244.
               10  FILLER          PIC X(12)       VALUE 'Owens'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001611212.
               10  FILLER          PIC X(12)       VALUE 'Mcdonald'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001609019.
               10  FILLER          PIC X(12)       VALUE 'Harrison'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001604295.
               10  FILLER          PIC X(12)       VALUE 'Ruiz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001602943.
               10  FILLER          PIC X(12)       VALUE 'Kennedy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001568285.
               10  FILLER          PIC X(12)       VALUE 'Wells'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001559139.
               10  FILLER          PIC X(12)       VALUE 'Alvarez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001542527.
               10  FILLER          PIC X(12)       VALUE 'Woods'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001542500.
               10  FILLER          PIC X(12)       VALUE 'Mendoza'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001540243.
               10  FILLER          PIC X(12)       VALUE 'Castillo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001511972.
               10  FILLER          PIC X(12)       VALUE 'Olson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001493963.
               10  FILLER          PIC X(12)       VALUE 'Webb'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001493771.
               10  FILLER          PIC X(12)       VALUE 'Washington'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001489705.
               10  FILLER          PIC X(12)       VALUE 'Tucker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001488763.
               10  FILLER          PIC X(12)       VALUE 'Freeman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001486507.
               10  FILLER          PIC X(12)       VALUE 'Burns'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001481636.
               10  FILLER          PIC X(12)       VALUE 'Henry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001474683.
               10  FILLER          PIC X(12)       VALUE 'Vasquez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001461863.
               10  FILLER          PIC X(12)       VALUE 'Snyder'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001456143.
               10  FILLER          PIC X(12)       VALUE 'Simpson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001445891.
               10  FILLER          PIC X(12)       VALUE 'Crawford'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001444795.
               10  FILLER          PIC X(12)       VALUE 'Jimenez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001438892.
               10  FILLER          PIC X(12)       VALUE 'Porter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001433163.
               10  FILLER          PIC X(12)       VALUE 'Mason'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001420700.
               10  FILLER          PIC X(12)       VALUE 'Shaw'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001417849.
               10  FILLER          PIC X(12)       VALUE 'Gordon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001415674.
               10  FILLER          PIC X(12)       VALUE 'Wagner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001411855.
               10  FILLER          PIC X(12)       VALUE 'Hunter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001410886.
               10  FILLER          PIC X(12)       VALUE 'Romero'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001405057.
               10  FILLER          PIC X(12)       VALUE 'Hicks'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001403650.
               10  FILLER          PIC X(12)       VALUE 'Dixon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001389003.
               10  FILLER          PIC X(12)       VALUE 'Hunt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001388738.
               10  FILLER          PIC X(12)       VALUE 'Palmer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001374310.
               10  FILLER          PIC X(12)       VALUE 'Robertson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001373323.
               10  FILLER          PIC X(12)       VALUE 'Black'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001372291.
               10  FILLER          PIC X(12)       VALUE 'Holmes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001372108.
               10  FILLER          PIC X(12)       VALUE 'Stone'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001368782.
               10  FILLER          PIC X(12)       VALUE 'Meyer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001367521.
               10  FILLER          PIC X(12)       VALUE 'Boyd'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001365803.
               10  FILLER          PIC X(12)       VALUE 'Mills'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001351485.
               10  FILLER          PIC X(12)       VALUE 'Warren'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001351458.
               10  FILLER          PIC X(12)       VALUE 'Fox'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001346441.
               10  FILLER          PIC X(12)       VALUE 'Rose'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001342485.
               10  FILLER          PIC X(12)       VALUE 'Rice'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001338062.
               10  FILLER          PIC X(12)       VALUE 'Moreno'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001334846.
               10  FILLER          PIC X(12)       VALUE 'Schmidt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001330067.
               10  FILLER          PIC X(12)       VALUE 'Patel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001325508.
               10  FILLER          PIC X(12)       VALUE 'Ferguson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001299832.
               10  FILLER          PIC X(12)       VALUE 'Nichols'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001296908.
               10  FILLER          PIC X(12)       VALUE 'Herrera'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001286400.
               10  FILLER          PIC X(12)       VALUE 'Medina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001273307.
               10  FILLER          PIC X(12)       VALUE 'Ryan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001273142.
               10  FILLER          PIC X(12)       VALUE 'Fernandez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001272841.
               10  FILLER          PIC X(12)       VALUE 'Weaver'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001268354.
               10  FILLER          PIC X(12)       VALUE 'Daniels'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001268034.
               10  FILLER          PIC X(12)       VALUE 'Stephens'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001267724.
               10  FILLER          PIC X(12)       VALUE 'Gardner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001266974.
               10  FILLER          PIC X(12)       VALUE 'Payne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001261200.
               10  FILLER          PIC X(12)       VALUE 'Kelley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001256878.
               10  FILLER          PIC X(12)       VALUE 'Dunn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001251395.
               10  FILLER          PIC X(12)       VALUE 'Pierce'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001247393.
               10  FILLER          PIC X(12)       VALUE 'Arnold'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001245547.
               10  FILLER          PIC X(12)       VALUE 'Tran'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001243537.
               10  FILLER          PIC X(12)       VALUE 'Spencer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001228443.
               10  FILLER          PIC X(12)       VALUE 'Peters'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001226505.
               10  FILLER          PIC X(12)       VALUE 'Hawkins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001224998.
               10  FILLER          PIC X(12)       VALUE 'Grant'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001224705.
               10  FILLER          PIC X(12)       VALUE 'Hansen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001219589.
               10  FILLER          PIC X(12)       VALUE 'Castro'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001217578.
               10  FILLER          PIC X(12)       VALUE 'Hoffman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001212014.
               10  FILLER          PIC X(12)       VALUE 'Hart'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001210378.
               10  FILLER          PIC X(12)       VALUE 'Elliott'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001210296.
               10  FILLER          PIC X(12)       VALUE 'Cunningham'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001205170.
               10  FILLER          PIC X(12)       VALUE 'Knight'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001204841.
               10  FILLER          PIC X(12)       VALUE 'Bradley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001199624.
               10  FILLER          PIC X(12)       VALUE 'Carroll'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001197166.
               10  FILLER          PIC X(12)       VALUE 'Hudson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001195091.
               10  FILLER          PIC X(12)       VALUE 'Duncan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001191674.
               10  FILLER          PIC X(12)       VALUE 'Armstrong'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001187681.
               10  FILLER          PIC X(12)       VALUE 'Berry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001182409.
               10  FILLER          PIC X(12)       VALUE 'Andrews'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001181632.
               10  FILLER          PIC X(12)       VALUE 'Johnston'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001178114.
               10  FILLER          PIC X(12)       VALUE 'Ray'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001176826.
               10  FILLER          PIC X(12)       VALUE 'Lane'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001176214.
               10  FILLER          PIC X(12)       VALUE 'Riley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001169206.
               10  FILLER          PIC X(12)       VALUE 'Carpenter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001161101.
               10  FILLER          PIC X(12)       VALUE 'Perkins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001159986.
               10  FILLER          PIC X(12)       VALUE 'Aguilar'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001154942.
               10  FILLER          PIC X(12)       VALUE 'Silva'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001152795.
               10  FILLER          PIC X(12)       VALUE 'Richards'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001148126.
               10  FILLER          PIC X(12)       VALUE 'Willis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001147888.
               10  FILLER          PIC X(12)       VALUE 'Matthews'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001140688.
               10  FILLER          PIC X(12)       VALUE 'Chapman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001138632.
               10  FILLER          PIC X(12)       VALUE 'Lawrence'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001135955.
               10  FILLER          PIC X(12)       VALUE 'Garza'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001134210.
               10  FILLER          PIC X(12)       VALUE 'Vargas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001132583.
               10  FILLER          PIC X(12)       VALUE 'Watkins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001118832.
               10  FILLER          PIC X(12)       VALUE 'Wheeler'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001111860.
               10  FILLER          PIC X(12)       VALUE 'Larson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001106195.
               10  FILLER          PIC X(12)       VALUE 'Carlson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001097606.
               10  FILLER          PIC X(12)       VALUE 'Harper'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001095267.
               10  FILLER          PIC X(12)       VALUE 'George'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001094444.
               10  FILLER          PIC X(12)       VALUE 'Greene'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001092855.
               10  FILLER          PIC X(12)       VALUE 'Burke'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001088935.
               10  FILLER          PIC X(12)       VALUE 'Guzman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001081762.
               10  FILLER          PIC X(12)       VALUE 'Morrison'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001077641.
               10  FILLER          PIC X(12)       VALUE 'Munoz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001076133.
               10  FILLER          PIC X(12)       VALUE 'Jacobs'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001055721.
               10  FILLER          PIC X(12)       VALUE 'Obrien'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001054304.
               10  FILLER          PIC X(12)       VALUE 'Lawson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001052486.
               10  FILLER          PIC X(12)       VALUE 'Franklin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001049498.
               10  FILLER          PIC X(12)       VALUE 'Lynch'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001045743.
               10  FILLER          PIC X(12)       VALUE 'Bishop'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001041960.
               10  FILLER          PIC X(12)       VALUE 'Carr'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001040662.
               10  FILLER          PIC X(12)       VALUE 'Salazar'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001036788.
               10  FILLER          PIC X(12)       VALUE 'Austin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001033974.
               10  FILLER          PIC X(12)       VALUE 'Mendez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001030100.
               10  FILLER          PIC X(12)       VALUE 'Gilbert'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001027084.
               10  FILLER          PIC X(12)       VALUE 'Jensen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001026408.
               10  FILLER          PIC X(12)       VALUE 'Williamson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001025348.
               10  FILLER          PIC X(12)       VALUE 'Montgomery'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001024690.
               10  FILLER          PIC X(12)       VALUE 'Harvey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001024617.
               10  FILLER          PIC X(12)       VALUE 'Oliver'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001020094.
               10  FILLER          PIC X(12)       VALUE 'Howell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.001001756.
               10  FILLER          PIC X(12)       VALUE 'Dean'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000998064.
               10  FILLER          PIC X(12)       VALUE 'Hanson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000996685.
               10  FILLER          PIC X(12)       VALUE 'Weber'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000985601.
               10  FILLER          PIC X(12)       VALUE 'Garrett'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000984788.
               10  FILLER          PIC X(12)       VALUE 'Sims'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000979918.
               10  FILLER          PIC X(12)       VALUE 'Burton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000979132.
               10  FILLER          PIC X(12)       VALUE 'Fuller'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000974783.
               10  FILLER          PIC X(12)       VALUE 'Soto'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000974317.
               10  FILLER          PIC X(12)       VALUE 'Mccoy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000972946.
               10  FILLER          PIC X(12)       VALUE 'Welch'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000966760.
               10  FILLER          PIC X(12)       VALUE 'Chen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000964384.
               10  FILLER          PIC X(12)       VALUE 'Schultz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000959067.
               10  FILLER          PIC X(12)       VALUE 'Walters'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000952844.
               10  FILLER          PIC X(12)       VALUE 'Reid'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000950340.
               10  FILLER          PIC X(12)       VALUE 'Fields'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000943350.
               10  FILLER          PIC X(12)       VALUE 'Walsh'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000943113.
               10  FILLER          PIC X(12)       VALUE 'Little'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000938563.
               10  FILLER          PIC X(12)       VALUE 'Fowler'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000937667.
               10  FILLER          PIC X(12)       VALUE 'Bowman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000934186.
               10  FILLER          PIC X(12)       VALUE 'Davidson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000932404.
               10  FILLER          PIC X(12)       VALUE 'May'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000929498.
               10  FILLER          PIC X(12)       VALUE 'Day'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000929041.
               10  FILLER          PIC X(12)       VALUE 'Schneider'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000918780.
               10  FILLER          PIC X(12)       VALUE 'Newman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000918214.
               10  FILLER          PIC X(12)       VALUE 'Brewer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000917976.
               10  FILLER          PIC X(12)       VALUE 'Lucas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000917538.
               10  FILLER          PIC X(12)       VALUE 'Holland'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000912677.
               10  FILLER          PIC X(12)       VALUE 'Wong'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000908172.
               10  FILLER          PIC X(12)       VALUE 'Banks'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000907276.
               10  FILLER          PIC X(12)       VALUE 'Santos'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000904526.
               10  FILLER          PIC X(12)       VALUE 'Curtis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000904206.
               10  FILLER          PIC X(12)       VALUE 'Pearson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000902105.
               10  FILLER          PIC X(12)       VALUE 'Delgado'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000901621.
               10  FILLER          PIC X(12)       VALUE 'Valdez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000901027.
               10  FILLER          PIC X(12)       VALUE 'Pena'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000898605.
               10  FILLER          PIC X(12)       VALUE 'Rios'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000882377.
               10  FILLER          PIC X(12)       VALUE 'Douglas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000881062.
               10  FILLER          PIC X(12)       VALUE 'Sandoval'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000879947.
               10  FILLER          PIC X(12)       VALUE 'Barrett'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000876228.
               10  FILLER          PIC X(12)       VALUE 'Hopkins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000864414.
               10  FILLER          PIC X(12)       VALUE 'Keller'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000861645.
               10  FILLER          PIC X(12)       VALUE 'Guerrero'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000860293.
               10  FILLER          PIC X(12)       VALUE 'Stanley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000857232.
               10  FILLER          PIC X(12)       VALUE 'Bates'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000856555.
               10  FILLER          PIC X(12)       VALUE 'Alvarado'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000856373.
               10  FILLER          PIC X(12)       VALUE 'Beck'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000851238.
               10  FILLER          PIC X(12)       VALUE 'Ortega'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000850963.
               10  FILLER          PIC X(12)       VALUE 'Wade'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000848250.
               10  FILLER          PIC X(12)       VALUE 'Estrada'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000848222.
               10  FILLER          PIC X(12)       VALUE 'Contreras'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000846660.
               10  FILLER          PIC X(12)       VALUE 'Barnett'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000843252.
               10  FILLER          PIC X(12)       VALUE 'Caldwell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000834580.
               10  FILLER          PIC X(12)       VALUE 'Santiago'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000831190.
               10  FILLER          PIC X(12)       VALUE 'Lambert'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000828001.
               10  FILLER          PIC X(12)       VALUE 'Powers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000826019.
               10  FILLER          PIC X(12)       VALUE 'Chambers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000825324.
               10  FILLER          PIC X(12)       VALUE 'Nunez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000824255.
               10  FILLER          PIC X(12)       VALUE 'Craig'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000818618.
               10  FILLER          PIC X(12)       VALUE 'Leonard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000815027.
               10  FILLER          PIC X(12)       VALUE 'Lowe'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000814844.
               10  FILLER          PIC X(12)       VALUE 'Rhodes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000812459.
               10  FILLER          PIC X(12)       VALUE 'Byrd'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000811490.
               10  FILLER          PIC X(12)       VALUE 'Gregory'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000811481.
               10  FILLER          PIC X(12)       VALUE 'Shelton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000807059.
               10  FILLER          PIC X(12)       VALUE 'Frazier'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000807050.
               10  FILLER          PIC X(12)       VALUE 'Becker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000805122.
               10  FILLER          PIC X(12)       VALUE 'Maldonado'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000804226.
               10  FILLER          PIC X(12)       VALUE 'Fleming'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000803614.
               10  FILLER          PIC X(12)       VALUE 'Vega'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000801595.
               10  FILLER          PIC X(12)       VALUE 'Sutton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000798351.
               10  FILLER          PIC X(12)       VALUE 'Cohen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000797008.
               10  FILLER          PIC X(12)       VALUE 'Jennings'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000795290.
               10  FILLER          PIC X(12)       VALUE 'Parks'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000788967.
               10  FILLER          PIC X(12)       VALUE 'Mcdaniel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000788702.
               10  FILLER          PIC X(12)       VALUE 'Watts'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000787889.
               10  FILLER          PIC X(12)       VALUE 'Barker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000778688.
               10  FILLER          PIC X(12)       VALUE 'Norris'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000778605.
               10  FILLER          PIC X(12)       VALUE 'Vaughn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000777006.
               10  FILLER          PIC X(12)       VALUE 'Vazquez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000775992.
               10  FILLER          PIC X(12)       VALUE 'Holt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000774018.
               10  FILLER          PIC X(12)       VALUE 'Schwartz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000773918.
               10  FILLER          PIC X(12)       VALUE 'Steele'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000770756.
               10  FILLER          PIC X(12)       VALUE 'Benson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000769660.
               10  FILLER          PIC X(12)       VALUE 'Neal'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000766151.
               10  FILLER          PIC X(12)       VALUE 'Dominguez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000765073.
               10  FILLER          PIC X(12)       VALUE 'Horton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000763173.
               10  FILLER          PIC X(12)       VALUE 'Terry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000762387.
               10  FILLER          PIC X(12)       VALUE 'Wolfe'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000759417.
               10  FILLER          PIC X(12)       VALUE 'Hale'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000757983.
               10  FILLER          PIC X(12)       VALUE 'Lyons'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000751614.
               10  FILLER          PIC X(12)       VALUE 'Graves'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000750892.
               10  FILLER          PIC X(12)       VALUE 'Haynes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000749595.
               10  FILLER          PIC X(12)       VALUE 'Miles'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000748644.
               10  FILLER          PIC X(12)       VALUE 'Park'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000748251.
               10  FILLER          PIC X(12)       VALUE 'Warner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000747648.
               10  FILLER          PIC X(12)       VALUE 'Padilla'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000747475.
               10  FILLER          PIC X(12)       VALUE 'Bush'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000744907.
               10  FILLER          PIC X(12)       VALUE 'Thornton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000741864.
               10  FILLER          PIC X(12)       VALUE 'Mccarthy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000740439.
               10  FILLER          PIC X(12)       VALUE 'Mann'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000740320.
               10  FILLER          PIC X(12)       VALUE 'Zimmerman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000739608.
               10  FILLER          PIC X(12)       VALUE 'Erickson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000739534.
               10  FILLER          PIC X(12)       VALUE 'Fletcher'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000739498.
               10  FILLER          PIC X(12)       VALUE 'Mckinney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000736610.
               10  FILLER          PIC X(12)       VALUE 'Page'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000735487.
               10  FILLER          PIC X(12)       VALUE 'Dawson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000732718.
               10  FILLER          PIC X(12)       VALUE 'Joseph'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000731256.
               10  FILLER          PIC X(12)       VALUE 'Marquez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000730534.
               10  FILLER          PIC X(12)       VALUE 'Reeves'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000729310.
               10  FILLER          PIC X(12)       VALUE 'Klein'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000728104.
               10  FILLER          PIC X(12)       VALUE 'Espinoza'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000724787.
               10  FILLER          PIC X(12)       VALUE 'Baldwin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000723224.
               10  FILLER          PIC X(12)       VALUE 'Moran'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000717696.
               10  FILLER          PIC X(12)       VALUE 'Love'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000715659.
               10  FILLER          PIC X(12)       VALUE 'Robbins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000713996.
               10  FILLER          PIC X(12)       VALUE 'Higgins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000713685.
               10  FILLER          PIC X(12)       VALUE 'Ball'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000708696.
               10  FILLER          PIC X(12)       VALUE 'Cortez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000708066.
               10  FILLER          PIC X(12)       VALUE 'Le'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000707709.
               10  FILLER          PIC X(12)       VALUE 'Griffith'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000707490.
               10  FILLER          PIC X(12)       VALUE 'Bowen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000704283.
               10  FILLER          PIC X(12)       VALUE 'Sharp'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000702364.
               10  FILLER          PIC X(12)       VALUE 'Cummings'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000700893.
               10  FILLER          PIC X(12)       VALUE 'Ramsey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000700144.
               10  FILLER          PIC X(12)       VALUE 'Hardy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000699988.
               10  FILLER          PIC X(12)       VALUE 'Swanson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000699358.
               10  FILLER          PIC X(12)       VALUE 'Barber'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000699038.
               10  FILLER          PIC X(12)       VALUE 'Acosta'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000698791.
               10  FILLER          PIC X(12)       VALUE 'Luna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000695593.
               10  FILLER          PIC X(12)       VALUE 'Chandler'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000695474.
               10  FILLER          PIC X(12)       VALUE 'Daniel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000686529.
               10  FILLER          PIC X(12)       VALUE 'Blair'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000686529.
               10  FILLER          PIC X(12)       VALUE 'Cross'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000686520.
               10  FILLER          PIC X(12)       VALUE 'Simon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000683824.
               10  FILLER          PIC X(12)       VALUE 'Dennis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000683322.
               10  FILLER          PIC X(12)       VALUE 'Oconnor'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000683066.
               10  FILLER          PIC X(12)       VALUE 'Quinn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000681010.
               10  FILLER          PIC X(12)       VALUE 'Gross'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000678762.
               10  FILLER          PIC X(12)       VALUE 'Navarro'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000675884.
               10  FILLER          PIC X(12)       VALUE 'Moss'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000673874.
               10  FILLER          PIC X(12)       VALUE 'Fitzgerald'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000671791.
               10  FILLER          PIC X(12)       VALUE 'Doyle'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000671754.
               10  FILLER          PIC X(12)       VALUE 'Mclaughlin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000668191.
               10  FILLER          PIC X(12)       VALUE 'Rojas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000667670.
               10  FILLER          PIC X(12)       VALUE 'Rodgers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000667213.
               10  FILLER          PIC X(12)       VALUE 'Stevenson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000666034.
               10  FILLER          PIC X(12)       VALUE 'Singh'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.0006637500.
               10  FILLER          PIC X(12)       VALUE 'Yang'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000663613.
               10  FILLER          PIC X(12)       VALUE 'Figueroa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000662754.
               10  FILLER          PIC X(12)       VALUE 'Harmon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000661667.
               10  FILLER          PIC X(12)       VALUE 'Newton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000660881.
               10  FILLER          PIC X(12)       VALUE 'Paul'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000660150.
               10  FILLER          PIC X(12)       VALUE 'Manning'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000658514.
               10  FILLER          PIC X(12)       VALUE 'Garner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000658359.
               10  FILLER          PIC X(12)       VALUE 'Mcgee'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000657198.
               10  FILLER          PIC X(12)       VALUE 'Reese'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000655636.
               10  FILLER          PIC X(12)       VALUE 'Francis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000655353.
               10  FILLER          PIC X(12)       VALUE 'Burgess'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000654265.
               10  FILLER          PIC X(12)       VALUE 'Adkins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000653571.
               10  FILLER          PIC X(12)       VALUE 'Goodman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000653151.
               10  FILLER          PIC X(12)       VALUE 'Curry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000651890.
               10  FILLER          PIC X(12)       VALUE 'Brady'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000650345.
               10  FILLER          PIC X(12)       VALUE 'Christensen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000650062.
               10  FILLER          PIC X(12)       VALUE 'Potter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000649688.
               10  FILLER          PIC X(12)       VALUE 'Walton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000648719.
               10  FILLER          PIC X(12)       VALUE 'Goodwin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000642652.
               10  FILLER          PIC X(12)       VALUE 'Mullins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000642222.
               10  FILLER          PIC X(12)       VALUE 'Molina'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000641537.
               10  FILLER          PIC X(12)       VALUE 'Webster'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000640733.
               10  FILLER          PIC X(12)       VALUE 'Fischer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000640477.
               10  FILLER          PIC X(12)       VALUE 'Campos'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000639152.
               10  FILLER          PIC X(12)       VALUE 'Avila'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000638175.
               10  FILLER          PIC X(12)       VALUE 'Sherman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000638147.
               10  FILLER          PIC X(12)       VALUE 'Todd'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000637873.
               10  FILLER          PIC X(12)       VALUE 'Chang'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000637380.
               10  FILLER          PIC X(12)       VALUE 'Blake'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000633021.
               10  FILLER          PIC X(12)       VALUE 'Malone'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000632820.
               10  FILLER          PIC X(12)       VALUE 'Wolf'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000629604.
               10  FILLER          PIC X(12)       VALUE 'Hodges'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000629266.
               10  FILLER          PIC X(12)       VALUE 'Juarez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000628507.
               10  FILLER          PIC X(12)       VALUE 'Gill'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000627722.
               10  FILLER          PIC X(12)       VALUE 'Farmer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000624158.
               10  FILLER          PIC X(12)       VALUE 'Hines'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000622660.
               10  FILLER          PIC X(12)       VALUE 'Gallagher'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000622020.
               10  FILLER          PIC X(12)       VALUE 'Duran'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000621755.
               10  FILLER          PIC X(12)       VALUE 'Hubbard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000621527.
               10  FILLER          PIC X(12)       VALUE 'Cannon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000620631.
               10  FILLER          PIC X(12)       VALUE 'Miranda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000618100.
               10  FILLER          PIC X(12)       VALUE 'Wang'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000617406.
               10  FILLER          PIC X(12)       VALUE 'Saunders'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000614116.
               10  FILLER          PIC X(12)       VALUE 'Tate'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000614098.
               10  FILLER          PIC X(12)       VALUE 'Mack'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000613604.
               10  FILLER          PIC X(12)       VALUE 'Hammond'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000612773.
               10  FILLER          PIC X(12)       VALUE 'Carrillo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000612691.
               10  FILLER          PIC X(12)       VALUE 'Townsend'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000610854.
               10  FILLER          PIC X(12)       VALUE 'Wise'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000609803.
               10  FILLER          PIC X(12)       VALUE 'Ingram'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000609136.
               10  FILLER          PIC X(12)       VALUE 'Barton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000608743.
               10  FILLER          PIC X(12)       VALUE 'Mejia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000607939.
               10  FILLER          PIC X(12)       VALUE 'Ayala'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000607766.
               10  FILLER          PIC X(12)       VALUE 'Schroeder'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000606825.
               10  FILLER          PIC X(12)       VALUE 'Hampton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000606514.
               10  FILLER          PIC X(12)       VALUE 'Rowe'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000604933.
               10  FILLER          PIC X(12)       VALUE 'Parsons'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000604915.
               10  FILLER          PIC X(12)       VALUE 'Frank'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000602311.
               10  FILLER          PIC X(12)       VALUE 'Waters'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000601388.
               10  FILLER          PIC X(12)       VALUE 'Strickland'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000601361.
               10  FILLER          PIC X(12)       VALUE 'Osborne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000601251.
               10  FILLER          PIC X(12)       VALUE 'Maxwell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000601041.
               10  FILLER          PIC X(12)       VALUE 'Chan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000600493.
               10  FILLER          PIC X(12)       VALUE 'Deleon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000599387.
               10  FILLER          PIC X(12)       VALUE 'Norman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000596381.
               10  FILLER          PIC X(12)       VALUE 'Harrington'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000595120.
               10  FILLER          PIC X(12)       VALUE 'Casey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000592232.
               10  FILLER          PIC X(12)       VALUE 'Patton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000591840.
               10  FILLER          PIC X(12)       VALUE 'Logan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000590049.
               10  FILLER          PIC X(12)       VALUE 'Bowers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000589318.
               10  FILLER          PIC X(12)       VALUE 'Mueller'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000587572.
               10  FILLER          PIC X(12)       VALUE 'Glover'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000586430.
               10  FILLER          PIC X(12)       VALUE 'Floyd'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000586074.
               10  FILLER          PIC X(12)       VALUE 'Hartman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000583205.
               10  FILLER          PIC X(12)       VALUE 'Buchanan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000583187.
               10  FILLER          PIC X(12)       VALUE 'Cobb'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000582401.
               10  FILLER          PIC X(12)       VALUE 'French'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000577010.
               10  FILLER          PIC X(12)       VALUE 'Kramer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000575858.
               10  FILLER          PIC X(12)       VALUE 'Mccormick'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000572569.
               10  FILLER          PIC X(12)       VALUE 'Clarke'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000571500.
               10  FILLER          PIC X(12)       VALUE 'Tyler'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000571390.
               10  FILLER          PIC X(12)       VALUE 'Gibbs'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000571208.
               10  FILLER          PIC X(12)       VALUE 'Moody'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000569654.
               10  FILLER          PIC X(12)       VALUE 'Conner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000569572.
               10  FILLER          PIC X(12)       VALUE 'Sparks'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000568649.
               10  FILLER          PIC X(12)       VALUE 'Mcguire'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000567571.
               10  FILLER          PIC X(12)       VALUE 'Leon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000566822.
               10  FILLER          PIC X(12)       VALUE 'Bauer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000566319.
               10  FILLER          PIC X(12)       VALUE 'Norton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000564729.
               10  FILLER          PIC X(12)       VALUE 'Pope'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000564227.
               10  FILLER          PIC X(12)       VALUE 'Flynn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000564199.
               10  FILLER          PIC X(12)       VALUE 'Hogan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000563322.
               10  FILLER          PIC X(12)       VALUE 'Robles'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000563030.
               10  FILLER          PIC X(12)       VALUE 'Salinas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000562692.
               10  FILLER          PIC X(12)       VALUE 'Yates'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000561029.
               10  FILLER          PIC X(12)       VALUE 'Lindsey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000559192.
               10  FILLER          PIC X(12)       VALUE 'Lloyd'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000558781.
               10  FILLER          PIC X(12)       VALUE 'Marsh'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000557365.
               10  FILLER          PIC X(12)       VALUE 'Mcbride'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000556222.
               10  FILLER          PIC X(12)       VALUE 'Owen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000552449.
               10  FILLER          PIC X(12)       VALUE 'Solis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000548648.
               10  FILLER          PIC X(12)       VALUE 'Pham'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000547770.
               10  FILLER          PIC X(12)       VALUE 'Lang'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000546802.
               10  FILLER          PIC X(12)       VALUE 'Pratt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000546418.
               10  FILLER          PIC X(12)       VALUE 'Lara'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000545779.
               10  FILLER          PIC X(12)       VALUE 'Brock'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000545331.
               10  FILLER          PIC X(12)       VALUE 'Ballard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000545130.
               10  FILLER          PIC X(12)       VALUE 'Trujillo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000544664.
               10  FILLER          PIC X(12)       VALUE 'Shaffer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000541173.
               10  FILLER          PIC X(12)       VALUE 'Drake'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000539602.
               10  FILLER          PIC X(12)       VALUE 'Roman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000539282.
               10  FILLER          PIC X(12)       VALUE 'Aguirre'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000538350.
               10  FILLER          PIC X(12)       VALUE 'Morton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000537162.
               10  FILLER          PIC X(12)       VALUE 'Stokes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000536239.
               10  FILLER          PIC X(12)       VALUE 'Lamb'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000535033.
               10  FILLER          PIC X(12)       VALUE 'Pacheco'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000534841.
               10  FILLER          PIC X(12)       VALUE 'Patrick'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000532310.
               10  FILLER          PIC X(12)       VALUE 'Cochran'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000532091.
               10  FILLER          PIC X(12)       VALUE 'Shepherd'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000529368.
               10  FILLER          PIC X(12)       VALUE 'Cain'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000528801.
               10  FILLER          PIC X(12)       VALUE 'Burnett'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000528674.
               10  FILLER          PIC X(12)       VALUE 'Hess'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000528335.
               10  FILLER          PIC X(12)       VALUE 'Li'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000528007.
               10  FILLER          PIC X(12)       VALUE 'Cervantes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000527084.
               10  FILLER          PIC X(12)       VALUE 'Olsen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000524087.
               10  FILLER          PIC X(12)       VALUE 'Briggs'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000523538.
               10  FILLER          PIC X(12)       VALUE 'Ochoa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000522743.
               10  FILLER          PIC X(12)       VALUE 'Cabrera'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000522387.
               10  FILLER          PIC X(12)       VALUE 'Velasquez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000522314.
               10  FILLER          PIC X(12)       VALUE 'Montoya'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000521510.
               10  FILLER          PIC X(12)       VALUE 'Roth'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000521099.
               10  FILLER          PIC X(12)       VALUE 'Meyers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000518485.
               10  FILLER          PIC X(12)       VALUE 'Cardenas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000517334.
               10  FILLER          PIC X(12)       VALUE 'Fuentes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000515717.
               10  FILLER          PIC X(12)       VALUE 'Weiss'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000513085.
               10  FILLER          PIC X(12)       VALUE 'Wilkins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000512309.
               10  FILLER          PIC X(12)       VALUE 'Hoover'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000512309.
               10  FILLER          PIC X(12)       VALUE 'Nicholson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000511559.
               10  FILLER          PIC X(12)       VALUE 'Underwood'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000511441.
               10  FILLER          PIC X(12)       VALUE 'Short'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000510801.
               10  FILLER          PIC X(12)       VALUE 'Carson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000510052.
               10  FILLER          PIC X(12)       VALUE 'Morrow'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000508617.
               10  FILLER          PIC X(12)       VALUE 'Colon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000507228.
               10  FILLER          PIC X(12)       VALUE 'Holloway'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000506808.
               10  FILLER          PIC X(12)       VALUE 'Summers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000506123.
               10  FILLER          PIC X(12)       VALUE 'Bryan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000505008.
               10  FILLER          PIC X(12)       VALUE 'Petersen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000504240.
               10  FILLER          PIC X(12)       VALUE 'Mckenzie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000503318.
               10  FILLER          PIC X(12)       VALUE 'Serrano'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000503071.
               10  FILLER          PIC X(12)       VALUE 'Wilcox'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000502431.
               10  FILLER          PIC X(12)       VALUE 'Carey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000501856.
               10  FILLER          PIC X(12)       VALUE 'Clayton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000501408.
               10  FILLER          PIC X(12)       VALUE 'Poole'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000499864.
               10  FILLER          PIC X(12)       VALUE 'Calderon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000499727.
               10  FILLER          PIC X(12)       VALUE 'Gallegos'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000499553.
               10  FILLER          PIC X(12)       VALUE 'Greer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000498996.
               10  FILLER          PIC X(12)       VALUE 'Rivas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000498786.
               10  FILLER          PIC X(12)       VALUE 'Guerra'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000498667.
               10  FILLER          PIC X(12)       VALUE 'Decker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000497525.
               10  FILLER          PIC X(12)       VALUE 'Collier'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000497196.
               10  FILLER          PIC X(12)       VALUE 'Wall'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000497077.
               10  FILLER          PIC X(12)       VALUE 'Whitaker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000496547.
               10  FILLER          PIC X(12)       VALUE 'Bass'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000496117.
               10  FILLER          PIC X(12)       VALUE 'Flowers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000495944.
               10  FILLER          PIC X(12)       VALUE 'Davenport'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000495295.
               10  FILLER          PIC X(12)       VALUE 'Conley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000495185.
               10  FILLER          PIC X(12)       VALUE 'Houston'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000493650.
               10  FILLER          PIC X(12)       VALUE 'Huff'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000492426.
               10  FILLER          PIC X(12)       VALUE 'Copeland'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000491320.
               10  FILLER          PIC X(12)       VALUE 'Hood'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000491010.
               10  FILLER          PIC X(12)       VALUE 'Monroe'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000488616.
               10  FILLER          PIC X(12)       VALUE 'Massey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000488470.
               10  FILLER          PIC X(12)       VALUE 'Roberson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000486085.
               10  FILLER          PIC X(12)       VALUE 'Combs'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000485920.
               10  FILLER          PIC X(12)       VALUE 'Franco'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000485747.
               10  FILLER          PIC X(12)       VALUE 'Larsen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000483937.
               10  FILLER          PIC X(12)       VALUE 'Pittman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000481434.
               10  FILLER          PIC X(12)       VALUE 'Randall'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000479661.
               10  FILLER          PIC X(12)       VALUE 'Skinner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000479616.
               10  FILLER          PIC X(12)       VALUE 'Wilkinson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000479552.
               10  FILLER          PIC X(12)       VALUE 'Kirby'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000479460.
               10  FILLER          PIC X(12)       VALUE 'Cameron'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000479150.
               10  FILLER          PIC X(12)       VALUE 'Bridges'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000477514.
               10  FILLER          PIC X(12)       VALUE 'Anthony'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000476472.
               10  FILLER          PIC X(12)       VALUE 'Richard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000476399.
               10  FILLER          PIC X(12)       VALUE 'Kirk'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000475650.
               10  FILLER          PIC X(12)       VALUE 'Bruce'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000475175.
               10  FILLER          PIC X(12)       VALUE 'Singleton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000473283.
               10  FILLER          PIC X(12)       VALUE 'Mathis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000473274.
               10  FILLER          PIC X(12)       VALUE 'Bradford'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000472635.
               10  FILLER          PIC X(12)       VALUE 'Boone'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000472205.
               10  FILLER          PIC X(12)       VALUE 'Abbott'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000471666.
               10  FILLER          PIC X(12)       VALUE 'Charles'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000470734.
               10  FILLER          PIC X(12)       VALUE 'Allison'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000470606.
               10  FILLER          PIC X(12)       VALUE 'Sweeney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000470570.
               10  FILLER          PIC X(12)       VALUE 'Atkinson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000470469.
               10  FILLER          PIC X(12)       VALUE 'Horn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000469473.
               10  FILLER          PIC X(12)       VALUE 'Jefferson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000469300.
               10  FILLER          PIC X(12)       VALUE 'Rosales'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000469071.
               10  FILLER          PIC X(12)       VALUE 'York'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000469053.
               10  FILLER          PIC X(12)       VALUE 'Christian'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000467618.
               10  FILLER          PIC X(12)       VALUE 'Phelps'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000467408.
               10  FILLER          PIC X(12)       VALUE 'Farrell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000466869.
               10  FILLER          PIC X(12)       VALUE 'Castaneda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000466814.
               10  FILLER          PIC X(12)       VALUE 'Nash'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000466193.
               10  FILLER          PIC X(12)       VALUE 'Dickerson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000466156.
               10  FILLER          PIC X(12)       VALUE 'Bond'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000465818.
               10  FILLER          PIC X(12)       VALUE 'Wyatt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000464850.
               10  FILLER          PIC X(12)       VALUE 'Foley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000464649.
               10  FILLER          PIC X(12)       VALUE 'Chase'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000463963.
               10  FILLER          PIC X(12)       VALUE 'Gates'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000463698.
               10  FILLER          PIC X(12)       VALUE 'Vincent'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000462602.
               10  FILLER          PIC X(12)       VALUE 'Mathews'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000462419.
               10  FILLER          PIC X(12)       VALUE 'Hodge'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000462136.
               10  FILLER          PIC X(12)       VALUE 'Garrison'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000461268.
               10  FILLER          PIC X(12)       VALUE 'Trevino'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000461012.
               10  FILLER          PIC X(12)       VALUE 'Villarreal'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000460071.
               10  FILLER          PIC X(12)       VALUE 'Heath'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000459669.
               10  FILLER          PIC X(12)       VALUE 'Dalton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000458380.
               10  FILLER          PIC X(12)       VALUE 'Valencia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000457101.
               10  FILLER          PIC X(12)       VALUE 'Callahan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000456178.
               10  FILLER          PIC X(12)       VALUE 'Hensley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000455566.
               10  FILLER          PIC X(12)       VALUE 'Atkins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000454616.
               10  FILLER          PIC X(12)       VALUE 'Huffman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000454461.
               10  FILLER          PIC X(12)       VALUE 'Roy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000454351.
               10  FILLER          PIC X(12)       VALUE 'Boyer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000453218.
               10  FILLER          PIC X(12)       VALUE 'Shields'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000452807.
               10  FILLER          PIC X(12)       VALUE 'Lin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000451016.
               10  FILLER          PIC X(12)       VALUE 'Hancock'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000450742.
               10  FILLER          PIC X(12)       VALUE 'Grimes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000449965.
               10  FILLER          PIC X(12)       VALUE 'Glenn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000449929.
               10  FILLER          PIC X(12)       VALUE 'Cline'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000449252.
               10  FILLER          PIC X(12)       VALUE 'Delacruz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000449170.
               10  FILLER          PIC X(12)       VALUE 'Camacho'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000447726.
               10  FILLER          PIC X(12)       VALUE 'Dillon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000446200.
               10  FILLER          PIC X(12)       VALUE 'Parrish'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000446109.
               10  FILLER          PIC X(12)       VALUE 'Oneill'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000444583.
               10  FILLER          PIC X(12)       VALUE 'Melton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000444017.
               10  FILLER          PIC X(12)       VALUE 'Booth'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000443889.
               10  FILLER          PIC X(12)       VALUE 'Kane'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000443404.
               10  FILLER          PIC X(12)       VALUE 'Berg'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000442975.
               10  FILLER          PIC X(12)       VALUE 'Harrell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000442893.
               10  FILLER          PIC X(12)       VALUE 'Pitts'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000442811.
               10  FILLER          PIC X(12)       VALUE 'Savage'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000441943.
               10  FILLER          PIC X(12)       VALUE 'Wiggins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000441833.
               10  FILLER          PIC X(12)       VALUE 'Brennan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000441294.
               10  FILLER          PIC X(12)       VALUE 'Salas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000441166.
               10  FILLER          PIC X(12)       VALUE 'Marks'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000441157.
               10  FILLER          PIC X(12)       VALUE 'Russo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000439740.
               10  FILLER          PIC X(12)       VALUE 'Sawyer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000438397.
               10  FILLER          PIC X(12)       VALUE 'Baxter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000437283.
               10  FILLER          PIC X(12)       VALUE 'Golden'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000437118.
               10  FILLER          PIC X(12)       VALUE 'Hutchinson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000436844.
               10  FILLER          PIC X(12)       VALUE 'Liu'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000435528.
               10  FILLER          PIC X(12)       VALUE 'Walter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000435071.
               10  FILLER          PIC X(12)       VALUE 'Mcdowell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000434258.
               10  FILLER          PIC X(12)       VALUE 'Wiley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000434048.
               10  FILLER          PIC X(12)       VALUE 'Rich'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000433810.
               10  FILLER          PIC X(12)       VALUE 'Humphrey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000433746.
               10  FILLER          PIC X(12)       VALUE 'Johns'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000432093.
               10  FILLER          PIC X(12)       VALUE 'Koch'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000432065.
               10  FILLER          PIC X(12)       VALUE 'Suarez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000431599.
               10  FILLER          PIC X(12)       VALUE 'Hobbs'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000431462.
               10  FILLER          PIC X(12)       VALUE 'Beard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000430621.
               10  FILLER          PIC X(12)       VALUE 'Gilmore'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000429909.
               10  FILLER          PIC X(12)       VALUE 'Ibarra'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000428492.
               10  FILLER          PIC X(12)       VALUE 'Keith'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000427140.
               10  FILLER          PIC X(12)       VALUE 'Macias'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000427067.
               10  FILLER          PIC X(12)       VALUE 'Khan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000426829.
               10  FILLER          PIC X(12)       VALUE 'Andrade'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000426729.
               10  FILLER          PIC X(12)       VALUE 'Ware'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000426546.
               10  FILLER          PIC X(12)       VALUE 'Stephenson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000426363.
               10  FILLER          PIC X(12)       VALUE 'Henson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000425879.
               10  FILLER          PIC X(12)       VALUE 'Wilkerson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000425843.
               10  FILLER          PIC X(12)       VALUE 'Dyer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000425559.
               10  FILLER          PIC X(12)       VALUE 'Mcclure'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000424929.
               10  FILLER          PIC X(12)       VALUE 'Blackwell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000424838.
               10  FILLER          PIC X(12)       VALUE 'Mercado'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000424308.
               10  FILLER          PIC X(12)       VALUE 'Tanner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000424079.
               10  FILLER          PIC X(12)       VALUE 'Eaton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000423997.
               10  FILLER          PIC X(12)       VALUE 'Clay'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000422727.
               10  FILLER          PIC X(12)       VALUE 'Barron'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000422106.
               10  FILLER          PIC X(12)       VALUE 'Beasley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000421950.
               10  FILLER          PIC X(12)       VALUE 'Oneal'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000421786.
               10  FILLER          PIC X(12)       VALUE 'Small'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000418944.
               10  FILLER          PIC X(12)       VALUE 'Preston'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000418944.
               10  FILLER          PIC X(12)       VALUE 'Wu'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000418624.
               10  FILLER          PIC X(12)       VALUE 'Zamora'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000418542.
               10  FILLER          PIC X(12)       VALUE 'Macdonald'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000418323.
               10  FILLER          PIC X(12)       VALUE 'Vance'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000418149.
               10  FILLER          PIC X(12)       VALUE 'Snow'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000417473.
               10  FILLER          PIC X(12)       VALUE 'Mcclain'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000416294.
               10  FILLER          PIC X(12)       VALUE 'Stafford'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000414366.
               10  FILLER          PIC X(12)       VALUE 'Orozco'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000413818.
               10  FILLER          PIC X(12)       VALUE 'Barry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000411579.
               10  FILLER          PIC X(12)       VALUE 'English'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000411470.
               10  FILLER          PIC X(12)       VALUE 'Shannon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000410282.
               10  FILLER          PIC X(12)       VALUE 'Kline'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000410264.
               10  FILLER          PIC X(12)       VALUE 'Jacobson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000410026.
               10  FILLER          PIC X(12)       VALUE 'Woodard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000409624.
               10  FILLER          PIC X(12)       VALUE 'Huang'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000408573.
               10  FILLER          PIC X(12)       VALUE 'Kemp'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000408445.
               10  FILLER          PIC X(12)       VALUE 'Mosley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000408418.
               10  FILLER          PIC X(12)       VALUE 'Prince'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000407888.
               10  FILLER          PIC X(12)       VALUE 'Merritt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000407760.
               10  FILLER          PIC X(12)       VALUE 'Hurst'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000407404.
               10  FILLER          PIC X(12)       VALUE 'Villanueva'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000407248.
               10  FILLER          PIC X(12)       VALUE 'Roach'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000406188.
               10  FILLER          PIC X(12)       VALUE 'Nolan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000405887.
               10  FILLER          PIC X(12)       VALUE 'Lam'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000405558.
               10  FILLER          PIC X(12)       VALUE 'Yoder'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000404279.
               10  FILLER          PIC X(12)       VALUE 'Mccullough'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000403164.
               10  FILLER          PIC X(12)       VALUE 'Lester'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000401300.
               10  FILLER          PIC X(12)       VALUE 'Santana'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000400898.
               10  FILLER          PIC X(12)       VALUE 'Valenzuela'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000399938.
               10  FILLER          PIC X(12)       VALUE 'Winters'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000399865.
               10  FILLER          PIC X(12)       VALUE 'Barrera'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000399482.
               10  FILLER          PIC X(12)       VALUE 'Orr'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000398988.
               10  FILLER          PIC X(12)       VALUE 'Leach'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000398988.
               10  FILLER          PIC X(12)       VALUE 'Berger'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000397983.
               10  FILLER          PIC X(12)       VALUE 'Mckee'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000397974.
               10  FILLER          PIC X(12)       VALUE 'Strong'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000396832.
               10  FILLER          PIC X(12)       VALUE 'Conway'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000396512.
               10  FILLER          PIC X(12)       VALUE 'Stein'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000395927.
               10  FILLER          PIC X(12)       VALUE 'Whitehead'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000395735.
               10  FILLER          PIC X(12)       VALUE 'Bullock'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000393095.
               10  FILLER          PIC X(12)       VALUE 'Escobar'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000392492.
               10  FILLER          PIC X(12)       VALUE 'Knox'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000392327.
               10  FILLER          PIC X(12)       VALUE 'Meadows'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000391843.
               10  FILLER          PIC X(12)       VALUE 'Solomon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000391432.
               10  FILLER          PIC X(12)       VALUE 'Velez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000391258.
               10  FILLER          PIC X(12)       VALUE 'Odonnell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000391094.
               10  FILLER          PIC X(12)       VALUE 'Kerr'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000390692.
               10  FILLER          PIC X(12)       VALUE 'Stout'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000389878.
               10  FILLER          PIC X(12)       VALUE 'Blankenship'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000389824.
               10  FILLER          PIC X(12)       VALUE 'Browning'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000389632.
               10  FILLER          PIC X(12)       VALUE 'Kent'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000389220.
               10  FILLER          PIC X(12)       VALUE 'Lozano'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000388946.
               10  FILLER          PIC X(12)       VALUE 'Bartlett'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000388444.
               10  FILLER          PIC X(12)       VALUE 'Pruitt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000387996.
               10  FILLER          PIC X(12)       VALUE 'Buck'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000387795.
               10  FILLER          PIC X(12)       VALUE 'Barr'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000387713.
               10  FILLER          PIC X(12)       VALUE 'Gaines'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000387137.
               10  FILLER          PIC X(12)       VALUE 'Durham'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000387101.
               10  FILLER          PIC X(12)       VALUE 'Gentry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000387028.
               10  FILLER          PIC X(12)       VALUE 'Mcintyre'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000386826.
               10  FILLER          PIC X(12)       VALUE 'Sloan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000386333.
               10  FILLER          PIC X(12)       VALUE 'Rocha'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000385036.
               10  FILLER          PIC X(12)       VALUE 'Melendez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000385036.
               10  FILLER          PIC X(12)       VALUE 'Herman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000384597.
               10  FILLER          PIC X(12)       VALUE 'Sexton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000384496.
               10  FILLER          PIC X(12)       VALUE 'Moon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000384332.
               10  FILLER          PIC X(12)       VALUE 'Hendricks'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000382660.
               10  FILLER          PIC X(12)       VALUE 'Rangel'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000382559.
               10  FILLER          PIC X(12)       VALUE 'Stark'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000382514.
               10  FILLER          PIC X(12)       VALUE 'Lowery'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000380750.
               10  FILLER          PIC X(12)       VALUE 'Hardin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000380695.
               10  FILLER          PIC X(12)       VALUE 'Hull'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000380622.
               10  FILLER          PIC X(12)       VALUE 'Sellers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000379754.
               10  FILLER          PIC X(12)       VALUE 'Ellison'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000378822.
               10  FILLER          PIC X(12)       VALUE 'Calhoun'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000378758.
               10  FILLER          PIC X(12)       VALUE 'Gillespie'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000378219.
               10  FILLER          PIC X(12)       VALUE 'Mora'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000377808.
               10  FILLER          PIC X(12)       VALUE 'Knapp'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000377068.
               10  FILLER          PIC X(12)       VALUE 'Mccall'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000376739.
               10  FILLER          PIC X(12)       VALUE 'Morse'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000375652.
               10  FILLER          PIC X(12)       VALUE 'Dorsey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000375579.
               10  FILLER          PIC X(12)       VALUE 'Weeks'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000375113.
               10  FILLER          PIC X(12)       VALUE 'Nielsen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000374692.
               10  FILLER          PIC X(12)       VALUE 'Livingston'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000374299.
               10  FILLER          PIC X(12)       VALUE 'Leblanc'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000373925.
               10  FILLER          PIC X(12)       VALUE 'Mclean'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000373450.
               10  FILLER          PIC X(12)       VALUE 'Bradshaw'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000372746.
               10  FILLER          PIC X(12)       VALUE 'Glass'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000372106.
               10  FILLER          PIC X(12)       VALUE 'Middleton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000371960.
               10  FILLER          PIC X(12)       VALUE 'Buckley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000371942.
               10  FILLER          PIC X(12)       VALUE 'Schaefer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000371549.
               10  FILLER          PIC X(12)       VALUE 'Frost'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000370809.
               10  FILLER          PIC X(12)       VALUE 'Howe'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000370562.
               10  FILLER          PIC X(12)       VALUE 'House'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000369849.
               10  FILLER          PIC X(12)       VALUE 'Mcintosh'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000369630.
               10  FILLER          PIC X(12)       VALUE 'Ho'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000369265.
               10  FILLER          PIC X(12)       VALUE 'Pennington'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000368588.
               10  FILLER          PIC X(12)       VALUE 'Reilly'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000368324.
               10  FILLER          PIC X(12)       VALUE 'Hebert'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000368077.
               10  FILLER          PIC X(12)       VALUE 'Mcfarland'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000367720.
               10  FILLER          PIC X(12)       VALUE 'Hickman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000367538.
               10  FILLER          PIC X(12)       VALUE 'Noble'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000367474.
               10  FILLER          PIC X(12)       VALUE 'Spears'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000367346.
               10  FILLER          PIC X(12)       VALUE 'Conrad'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000366423.
               10  FILLER          PIC X(12)       VALUE 'Arias'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000366277.
               10  FILLER          PIC X(12)       VALUE 'Galvan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000365911.
               10  FILLER          PIC X(12)       VALUE 'Velazquez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000365765.
               10  FILLER          PIC X(12)       VALUE 'Huynh'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000365591.
               10  FILLER          PIC X(12)       VALUE 'Frederick'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000364659.
               10  FILLER          PIC X(12)       VALUE 'Randolph'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000363134.
               10  FILLER          PIC X(12)       VALUE 'Cantu'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000361845.
               10  FILLER          PIC X(12)       VALUE 'Fitzpatrick'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000360931.
               10  FILLER          PIC X(12)       VALUE 'Mahoney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000360374.
               10  FILLER          PIC X(12)       VALUE 'Peck'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000360301.
               10  FILLER          PIC X(12)       VALUE 'Villa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000360027.
               10  FILLER          PIC X(12)       VALUE 'Michael'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000359725.
               10  FILLER          PIC X(12)       VALUE 'Donovan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000358821.
               10  FILLER          PIC X(12)       VALUE 'Mcconnell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000358209.
               10  FILLER          PIC X(12)       VALUE 'Walls'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000357870.
               10  FILLER          PIC X(12)       VALUE 'Boyle'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000357642.
               10  FILLER          PIC X(12)       VALUE 'Mayer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000357368.
               10  FILLER          PIC X(12)       VALUE 'Zuniga'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000356875.
               10  FILLER          PIC X(12)       VALUE 'Giles'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000356372.
               10  FILLER          PIC X(12)       VALUE 'Pineda'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000356345.
               10  FILLER          PIC X(12)       VALUE 'Pace'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000356125.
               10  FILLER          PIC X(12)       VALUE 'Hurley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000356089.
               10  FILLER          PIC X(12)       VALUE 'Mays'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000355568.
               10  FILLER          PIC X(12)       VALUE 'Mcmillan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000355403.
               10  FILLER          PIC X(12)       VALUE 'Crosby'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000354928.
               10  FILLER          PIC X(12)       VALUE 'Ayers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000354855.
               10  FILLER          PIC X(12)       VALUE 'Case'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000354152.
               10  FILLER          PIC X(12)       VALUE 'Bentley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000353740.
               10  FILLER          PIC X(12)       VALUE 'Shepard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000353658.
               10  FILLER          PIC X(12)       VALUE 'Everett'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000353631.
               10  FILLER          PIC X(12)       VALUE 'Pugh'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000353530.
               10  FILLER          PIC X(12)       VALUE 'David'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000353238.
               10  FILLER          PIC X(12)       VALUE 'Mcmahon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000352306.
               10  FILLER          PIC X(12)       VALUE 'Dunlap'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000351931.
               10  FILLER          PIC X(12)       VALUE 'Bender'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000351456.
               10  FILLER          PIC X(12)       VALUE 'Hahn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000350451.
               10  FILLER          PIC X(12)       VALUE 'Harding'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000350323.
               10  FILLER          PIC X(12)       VALUE 'Acevedo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000349336.
               10  FILLER          PIC X(12)       VALUE 'Raymond'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000348660.
               10  FILLER          PIC X(12)       VALUE 'Blackburn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000348468.
               10  FILLER          PIC X(12)       VALUE 'Duffy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000346869.
               10  FILLER          PIC X(12)       VALUE 'Landry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000346860.
               10  FILLER          PIC X(12)       VALUE 'Dougherty'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000346330.
               10  FILLER          PIC X(12)       VALUE 'Bautista'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000345818.
               10  FILLER          PIC X(12)       VALUE 'Shah'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000345690.
               10  FILLER          PIC X(12)       VALUE 'Potts'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000344356.
               10  FILLER          PIC X(12)       VALUE 'Arroyo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000344274.
               10  FILLER          PIC X(12)       VALUE 'Valentine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000344192.
               10  FILLER          PIC X(12)       VALUE 'Meza'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000344128.
               10  FILLER          PIC X(12)       VALUE 'Gould'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000344110.
               10  FILLER          PIC X(12)       VALUE 'Vaughan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000343479.
               10  FILLER          PIC X(12)       VALUE 'Fry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000343032.
               10  FILLER          PIC X(12)       VALUE 'Rush'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000342374.
               10  FILLER          PIC X(12)       VALUE 'Avery'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000342100.
               10  FILLER          PIC X(12)       VALUE 'Herring'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000341305.
               10  FILLER          PIC X(12)       VALUE 'Dodson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000340802.
               10  FILLER          PIC X(12)       VALUE 'Clements'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000340245.
               10  FILLER          PIC X(12)       VALUE 'Sampson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000340217.
               10  FILLER          PIC X(12)       VALUE 'Tapia'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000339916.
               10  FILLER          PIC X(12)       VALUE 'Bean'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000339404.
               10  FILLER          PIC X(12)       VALUE 'Lynn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000339221.
               10  FILLER          PIC X(12)       VALUE 'Crane'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000339203.
               10  FILLER          PIC X(12)       VALUE 'Farley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000339139.
               10  FILLER          PIC X(12)       VALUE 'Cisneros'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000338536.
               10  FILLER          PIC X(12)       VALUE 'Benton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000338372.
               10  FILLER          PIC X(12)       VALUE 'Ashley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000338271.
               10  FILLER          PIC X(12)       VALUE 'Mckay'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000337604.
               10  FILLER          PIC X(12)       VALUE 'Finley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000336928.
               10  FILLER          PIC X(12)       VALUE 'Best'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000336818.
               10  FILLER          PIC X(12)       VALUE 'Blevins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000336626.
               10  FILLER          PIC X(12)       VALUE 'Friedman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000336553.
               10  FILLER          PIC X(12)       VALUE 'Moses'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000336380.
               10  FILLER          PIC X(12)       VALUE 'Sosa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000336370.
               10  FILLER          PIC X(12)       VALUE 'Blanchard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000335923.
               10  FILLER          PIC X(12)       VALUE 'Huber'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000335603.
               10  FILLER          PIC X(12)       VALUE 'Frye'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000335484.
               10  FILLER          PIC X(12)       VALUE 'Krueger'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000335283.
               10  FILLER          PIC X(12)       VALUE 'Bernard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000333931.
               10  FILLER          PIC X(12)       VALUE 'Rosario'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000333867.
               10  FILLER          PIC X(12)       VALUE 'Rubio'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000333794.
               10  FILLER          PIC X(12)       VALUE 'Mullen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000332981.
               10  FILLER          PIC X(12)       VALUE 'Benjamin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000332953.
               10  FILLER          PIC X(12)       VALUE 'Haley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000332898.
               10  FILLER          PIC X(12)       VALUE 'Chung'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000332798.
               10  FILLER          PIC X(12)       VALUE 'Moyer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000332789.
               10  FILLER          PIC X(12)       VALUE 'Choi'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000332505.
               10  FILLER          PIC X(12)       VALUE 'Horne'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000331573.
               10  FILLER          PIC X(12)       VALUE 'Yu'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000331546.
               10  FILLER          PIC X(12)       VALUE 'Woodward'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000331153.
               10  FILLER          PIC X(12)       VALUE 'Ali'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000329664.
               10  FILLER          PIC X(12)       VALUE 'Nixon'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000329280.
               10  FILLER          PIC X(12)       VALUE 'Hayden'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000329161.
               10  FILLER          PIC X(12)       VALUE 'Rivers'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000328759.
               10  FILLER          PIC X(12)       VALUE 'Estes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000327471.
               10  FILLER          PIC X(12)       VALUE 'Mccarty'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000326365.
               10  FILLER          PIC X(12)       VALUE 'Richmond'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000326338.
               10  FILLER          PIC X(12)       VALUE 'Stuart'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000326210.
               10  FILLER          PIC X(12)       VALUE 'Maynard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000325726.
               10  FILLER          PIC X(12)       VALUE 'Brandt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000325433.
               10  FILLER          PIC X(12)       VALUE 'Oconnell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000325378.
               10  FILLER          PIC X(12)       VALUE 'Hanna'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000325278.
               10  FILLER          PIC X(12)       VALUE 'Sanford'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000324967.
               10  FILLER          PIC X(12)       VALUE 'Sheppard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000324867.
               10  FILLER          PIC X(12)       VALUE 'Church'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000324730.
               10  FILLER          PIC X(12)       VALUE 'Burch'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000324565.
               10  FILLER          PIC X(12)       VALUE 'Levy'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000324044.
               10  FILLER          PIC X(12)       VALUE 'Rasmussen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000323944.
               10  FILLER          PIC X(12)       VALUE 'Coffey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000323843.
               10  FILLER          PIC X(12)       VALUE 'Ponce'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000323459.
               10  FILLER          PIC X(12)       VALUE 'Faulkner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000323359.
               10  FILLER          PIC X(12)       VALUE 'Donaldson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000323341.
               10  FILLER          PIC X(12)       VALUE 'Schmitt'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000322783.
               10  FILLER          PIC X(12)       VALUE 'Novak'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000322381.
               10  FILLER          PIC X(12)       VALUE 'Costa'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000321879.
               10  FILLER          PIC X(12)       VALUE 'Montes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000321595.
               10  FILLER          PIC X(12)       VALUE 'Booker'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000320727.
               10  FILLER          PIC X(12)       VALUE 'Cordova'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000320481.
               10  FILLER          PIC X(12)       VALUE 'Waller'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000319814.
               10  FILLER          PIC X(12)       VALUE 'Arellano'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000319795.
               10  FILLER          PIC X(12)       VALUE 'Maddox'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000319530.
               10  FILLER          PIC X(12)       VALUE 'Mata'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000318781.
               10  FILLER          PIC X(12)       VALUE 'Bonilla'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000318196.
               10  FILLER          PIC X(12)       VALUE 'Stanton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000318087.
               10  FILLER          PIC X(12)       VALUE 'Compton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000317867.
               10  FILLER          PIC X(12)       VALUE 'Kaufman'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000317849.
               10  FILLER          PIC X(12)       VALUE 'Dudley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000317703.
               10  FILLER          PIC X(12)       VALUE 'Mcpherson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000317639.
               10  FILLER          PIC X(12)       VALUE 'Beltran'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000317392.
               10  FILLER          PIC X(12)       VALUE 'Dickson'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000317045.
               10  FILLER          PIC X(12)       VALUE 'Mccann'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000316990.
               10  FILLER          PIC X(12)       VALUE 'Villegas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000316917.
               10  FILLER          PIC X(12)       VALUE 'Proctor'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000316899.
               10  FILLER          PIC X(12)       VALUE 'Hester'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000316835.
               10  FILLER          PIC X(12)       VALUE 'Cantrell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000316826.
               10  FILLER          PIC X(12)       VALUE 'Daugherty'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000316607.
               10  FILLER          PIC X(12)       VALUE 'Cherry'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000316287.
               10  FILLER          PIC X(12)       VALUE 'Bray'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000315921.
               10  FILLER          PIC X(12)       VALUE 'Davila'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000315611.
               10  FILLER          PIC X(12)       VALUE 'Rowland'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000315218.
               10  FILLER          PIC X(12)       VALUE 'Madden'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000314980.
               10  FILLER          PIC X(12)       VALUE 'Levine'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000314980.
               10  FILLER          PIC X(12)       VALUE 'Spence'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000314642.
               10  FILLER          PIC X(12)       VALUE 'Good'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000314596.
               10  FILLER          PIC X(12)       VALUE 'Irwin'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000314085.
               10  FILLER          PIC X(12)       VALUE 'Werner'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000313884.
               10  FILLER          PIC X(12)       VALUE 'Krause'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000313820.
               10  FILLER          PIC X(12)       VALUE 'Petty'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000313207.
               10  FILLER          PIC X(12)       VALUE 'Whitney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000312961.
               10  FILLER          PIC X(12)       VALUE 'Baird'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000312796.
               10  FILLER          PIC X(12)       VALUE 'Hooper'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000311435.
               10  FILLER          PIC X(12)       VALUE 'Pollard'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000311389.
               10  FILLER          PIC X(12)       VALUE 'Zavala'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000311289.
               10  FILLER          PIC X(12)       VALUE 'Jarvis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000311124.
               10  FILLER          PIC X(12)       VALUE 'Holden'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000311042.
               10  FILLER          PIC X(12)       VALUE 'Hendrix'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000310960.
               10  FILLER          PIC X(12)       VALUE 'Haas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000310960.
               10  FILLER          PIC X(12)       VALUE 'Mcgrath'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000310951.
               10  FILLER          PIC X(12)       VALUE 'Bird'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000310320.
               10  FILLER          PIC X(12)       VALUE 'Lucero'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000309955.
               10  FILLER          PIC X(12)       VALUE 'Terrell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000309882.
               10  FILLER          PIC X(12)       VALUE 'Riggs'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000309461.
               10  FILLER          PIC X(12)       VALUE 'Joyce'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000309233.
               10  FILLER          PIC X(12)       VALUE 'Rollins'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000308812.
               10  FILLER          PIC X(12)       VALUE 'Mercer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000308812.
               10  FILLER          PIC X(12)       VALUE 'Galloway'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000308593.
               10  FILLER          PIC X(12)       VALUE 'Duke'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000308337.
               10  FILLER          PIC X(12)       VALUE 'Odom'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000308081.
               10  FILLER          PIC X(12)       VALUE 'Andersen'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000306172.
               10  FILLER          PIC X(12)       VALUE 'Downs'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000306044.
               10  FILLER          PIC X(12)       VALUE 'Hatfield'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000305770.
               10  FILLER          PIC X(12)       VALUE 'Benitez'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000305560.
               10  FILLER          PIC X(12)       VALUE 'Archer'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000305285.
               10  FILLER          PIC X(12)       VALUE 'Huerta'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000304710.
               10  FILLER          PIC X(12)       VALUE 'Travis'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000304628.
               10  FILLER          PIC X(12)       VALUE 'Mcneil'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000303714.
               10  FILLER          PIC X(12)       VALUE 'Hinton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000303440.
               10  FILLER          PIC X(12)       VALUE 'Zhang'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000303376.
               10  FILLER          PIC X(12)       VALUE 'Hays'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000303303.
               10  FILLER          PIC X(12)       VALUE 'Mayo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000302681.
               10  FILLER          PIC X(12)       VALUE 'Fritz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000302151.
               10  FILLER          PIC X(12)       VALUE 'Branch'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000301896.
               10  FILLER          PIC X(12)       VALUE 'Mooney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000301101.
               10  FILLER          PIC X(12)       VALUE 'Ewing'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000300845.
               10  FILLER          PIC X(12)       VALUE 'Ritter'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000300287.
               10  FILLER          PIC X(12)       VALUE 'Esparza'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000299447.
               10  FILLER          PIC X(12)       VALUE 'Frey'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000299109.
               10  FILLER          PIC X(12)       VALUE 'Braun'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000298570.
               10  FILLER          PIC X(12)       VALUE 'Gay'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000298533.
               10  FILLER          PIC X(12)       VALUE 'Riddle'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000298369.
               10  FILLER          PIC X(12)       VALUE 'Haney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000298277.
               10  FILLER          PIC X(12)       VALUE 'Kaiser'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000297574.
               10  FILLER          PIC X(12)       VALUE 'Holder'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000296651.
               10  FILLER          PIC X(12)       VALUE 'Chaney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000296349.
               10  FILLER          PIC X(12)       VALUE 'Mcknight'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000295920.
               10  FILLER          PIC X(12)       VALUE 'Gamble'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000295838.
               10  FILLER          PIC X(12)       VALUE 'Vang'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000295435.
               10  FILLER          PIC X(12)       VALUE 'Cooley'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000295015.
               10  FILLER          PIC X(12)       VALUE 'Carney'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000294969.
               10  FILLER          PIC X(12)       VALUE 'Cowan'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000294604.
               10  FILLER          PIC X(12)       VALUE 'Forbes'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000294476.
               10  FILLER          PIC X(12)       VALUE 'Ferrell'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000293983.
               10  FILLER          PIC X(12)       VALUE 'Davies'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000293900.
               10  FILLER          PIC X(12)       VALUE 'Barajas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000293736.
               10  FILLER          PIC X(12)       VALUE 'Shea'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000293023.
               10  FILLER          PIC X(12)       VALUE 'Osborn'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000292795.
               10  FILLER          PIC X(12)       VALUE 'Bright'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000292777.
               10  FILLER          PIC X(12)       VALUE 'Cuevas'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000292530.
               10  FILLER          PIC X(12)       VALUE 'Bolton'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000292347.
               10  FILLER          PIC X(12)       VALUE 'Murillo'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000292064.
               10  FILLER          PIC X(12)       VALUE 'Lutz'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000291845.
               10  FILLER          PIC X(12)       VALUE 'Duarte'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000291442.
               10  FILLER          PIC X(12)       VALUE 'Kidd'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000291351.
               10  FILLER          PIC X(12)       VALUE 'Key'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000291315.
               10  FILLER          PIC X(12)       VALUE 'Cooke'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.000291114.
           05  FILLER REDEFINES LAST-NAME-OCCS.
               10  FILLER                          OCCURS 1000
                                                   INDEXED LN-DX.
                   15  LAST-NAME   PIC X(12).
                   15  LAST-NAME-WEIGHT
                                   PIC SV9(9) COMP.

       01  PREFIXES-FEMALE.
           05  PREFIX-FEMALE-CNT   PIC S9(04) COMP VALUE 4.
           05  PREFIX-FEMALE-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  PREFIX-FEMALE-OCCS.
               10  FILLER          PIC X(12)       VALUE 'Mrs.'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.500000000.
               10  FILLER          PIC X(12)       VALUE 'Ms.'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.100000000.
               10  FILLER          PIC X(12)       VALUE 'Miss'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.100000000.
               10  FILLER          PIC X(12)       VALUE 'Dr.'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.300000000.
           05  FILLER REDEFINES PREFIX-FEMALE-OCCS.
               10  FILLER                          OCCURS 4
                                                   INDEXED PF-DX.
                   15  PREFIX-FEMALE 
                                   PIC X(12).
                   15  PREFIX-FEMALE-WEIGHT
                                   PIC SV9(9) COMP.
                                       
       01  PREFIXES-MALE.
           05  PREFIX-MALE-CNT     PIC S9(4)  COMP VALUE 2.
           05  PREFIX-MALE-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  PREFIX-MALE-OCCS.
               10  FILLER          PIC X(12)       VALUE 'Mr.'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.700000000.
               10  FILLER          PIC X(12)       VALUE 'Dr.'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.300000000.
           05  FILLER REDEFINES PREFIX-MALE-OCCS.
               10  FILLER                          OCCURS 2
                                                   INDEXED PM-DX.
                   15  PREFIX-MALE 
                                   PIC X(12).
                   15  PREFIX-MALE-WEIGHT
                                   PIC SV9(9) COMP.

       01  SUFFIXES-FEMALE.
           05  SUFFIX-FEMALE-CNT   PIC S9(4)  COMP VALUE 4.
           05  SUFFIX-FEMALE-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  SUFFIX-FEMALE-OCCS.
               10  FILLER          PIC X(12)       VALUE 'MD'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.500000000.
               10  FILLER          PIC X(12)       VALUE 'DDS'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.300000000.
               10  FILLER          PIC X(12)       VALUE 'PhD'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.100000000.
               10  FILLER          PIC X(12)       VALUE 'DVM'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.200000000.
           05  FILLER REDEFINES SUFFIX-FEMALE-OCCS.
               10  FILLER                          OCCURS 4
                                                   INDEXED SF-DX.
                   15  SUFFIX-FEMALE 
                                   PIC X(12).
                   15  SUFFIX-FEMALE-WEIGHT
                                   PIC SV9(9) COMP.

      * Removed Sr and I as they'd almost never be part of legal names.

       01  SUFFIXES-MALE.
           05  SUFFIX-MALE-CNT     PIC S9(4)  COMP VALUE 9.
           05  SUFFIX-MALE-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  SUFFIX-MALE-OCCS.
               10  FILLER          PIC X(12)       VALUE 'Jr.'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.200000000.
               10  FILLER          PIC X(12)       VALUE 'II'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.050000000.
               10  FILLER          PIC X(12)       VALUE 'III'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.030000000.
               10  FILLER          PIC X(12)       VALUE 'IV'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.015000000.
               10  FILLER          PIC X(12)       VALUE 'V'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.005000000.
               10  FILLER          PIC X(12)       VALUE 'MD'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.300000000.
               10  FILLER          PIC X(12)       VALUE 'DDS'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.200000000.
               10  FILLER          PIC X(12)       VALUE 'PhD'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.100000000.
               10  FILLER          PIC X(12)       VALUE 'DVM'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.100000000.
           05  FILLER REDEFINES SUFFIX-MALE-OCCS.
               10  FILLER                          OCCURS 9
                                                   INDEXED SM-DX.
                   15  SUFFIX-MALE PIC X(12).
                   15  SUFFIX-MALE-WEIGHT
                                   PIC SV9(9) COMP.
