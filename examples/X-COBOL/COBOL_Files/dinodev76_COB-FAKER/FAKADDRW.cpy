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
      ****     BN = building_number
      ****     CP = city_prefix
      ****     CS = city suffix
      ****     CT = city
      ****     FN = first_name (from FAKPERSW)
      ****     LN = last_name (from FAKPERSW)
      ****     MA = military_apo
      ****     MD = military_dpo
      ****     MS = military_state
      ****     M$ = military_ship
      ****     PC = postcode
      ****     SA = street_address
      ****     SN = street_name
      ****     SS = street_suffix
      ****     ST = state_abbr
      ****     SP = state_postcode
      ****     2A = secondary_address

      **** All hash sign ('#') occurrences are replaced with a random
      **** digit (0 to 9).
      **** All percentage sign ('%') occurrences are replaced with a
      **** random non-zero digit (1 to 9).

       01  FORMATS-CITY.
           05  FORMAT-CITY-CNT     PIC S9(4)  COMP VALUE 4.
           05  FORMAT-CITY-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  FORMAT-CITY-OCCS.
               10  FILLER          PIC X(32)       VALUE 
                                                        '{CP} {FN}{CS}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.250000000.
               10  FILLER          PIC X(32)       VALUE '{CP} {FN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.250000000.
               10  FILLER          PIC X(32)       VALUE '{FN}{CS}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.250000000.
               10  FILLER          PIC X(32)       VALUE '{LN}{CS}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.250000000.
           05  FILLER REDEFINES FORMAT-CITY-OCCS.
               10  FILLER                          OCCURS 4
                                                   INDEXED FC-DX.
                   15  FORMAT-CITY PIC X(32).
                   15  FORMAT-CITY-WEIGHT
                                   PIC SV9(9) COMP.

       01  FORMATS-STREET-NAME.
           05  FORMAT-STREET-NAME-CNT
                                   PIC S9(4)  COMP VALUE 2.
           05  FORMAT-STREET-NAME-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  FORMAT-STREET-NAME-OCCS.
               10  FILLER          PIC X(32)       VALUE '{FN} {SS}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.500000000.
               10  FILLER          PIC X(32)       VALUE '{LN} {SS}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.500000000.
           05  FILLER REDEFINES FORMAT-STREET-NAME-OCCS.
               10  FILLER                          OCCURS 2
                                                   INDEXED FSN-DX.
                   15  FORMAT-STREET-NAME
                                   PIC X(32).
                   15  FORMAT-STREET-NAME-WEIGHT
                                   PIC SV9(9) COMP.

       01  FORMATS-STREET-ADDR.
           05  FORMAT-STREET-ADDR-CNT
                                   PIC S9(4)  COMP VALUE 2.
           05  FORMAT-STREET-ADDR-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  FORMAT-STREET-ADDR-OCCS.
               10  FILLER          PIC X(32)       VALUE '{BN} {SN}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.900000000.
               10  FILLER          PIC X(32)       VALUE
                                                      '{BN} {SN}, {2A}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.100000000.
           05  FILLER REDEFINES FORMAT-STREET-ADDR-OCCS.
               10  FILLER                          OCCURS 2
                                                   INDEXED FSA-DX.
                   15  FORMAT-STREET-ADDR
                                   PIC X(32).
                   15  FORMAT-STREET-ADDR-WEIGHT
                                   PIC SV9(9) COMP.

       01  FORMATS-ADDRESS.
           05  FORMAT-ADDRESS-CNT
                                   PIC S9(4)  COMP VALUE 4.
           05  FORMAT-ADDRESS-WEIGHT-TOT
                                   PIC S99V9(9)
                                              COMP VALUE 0.
           05  FORMAT-ADDRESS-OCCS.
               10  FILLER          PIC X(32)       VALUE
                                                '{SA}\n{CT}, {SP}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.990000000.
               10  FILLER          PIC X(32)       VALUE
                                                  '{MA}\nAPO {MS} {PC}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.004000000.
               10  FILLER          PIC X(32)       VALUE
                                             '{M$} {LN}\nFPO {MS} {PC}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003000000.
               10  FILLER          PIC X(32)       VALUE
                                                  '{MD}\nDPO {MS} {PC}'.
               10  FILLER          PIC SV9(9) COMP VALUE  0.003000000.
           05  FILLER REDEFINES FORMAT-ADDRESS-OCCS.
               10  FILLER                          OCCURS 4
                                                   INDEXED FA-DX.
                   15  FORMAT-ADDRESS
                                   PIC X(32).
                   15  FORMAT-ADDRESS-WEIGHT
                                   PIC SV9(9) COMP.

       01  CITY-PREFIXES.
           05  CITY-PREFIX-CNT     PIC S9(4)  COMP VALUE 7.
           05  CITY-PREFIX-OCCS.
               10  FILLER          PIC X(14)       VALUE 'North'.
               10  FILLER          PIC X(14)       VALUE 'East'.
               10  FILLER          PIC X(14)       VALUE 'West'.
               10  FILLER          PIC X(14)       VALUE 'South'.
               10  FILLER          PIC X(14)       VALUE 'New'.
               10  FILLER          PIC X(14)       VALUE 'Lake'.
               10  FILLER          PIC X(14)       VALUE 'Port'.
           05  FILLER REDEFINES CITY-PREFIX-OCCS.
               10  FILLER                          OCCURS 7
                                                   INDEXED CP-DX.
                   15  CITY-PREFIX PIC X(14).

       01  CITY-SUFFIXES.
           05  CITY-SUFFIX-CNT     PIC S9(4)  COMP VALUE 19.
           05  CITY-SUFFIX-OCCS.
               10  FILLER          PIC X(14)       VALUE 'town'.
               10  FILLER          PIC X(14)       VALUE 'ton'.
               10  FILLER          PIC X(14)       VALUE 'land'.
               10  FILLER          PIC X(14)       VALUE 'ville'.
               10  FILLER          PIC X(14)       VALUE 'berg'.
               10  FILLER          PIC X(14)       VALUE 'burgh'.
               10  FILLER          PIC X(14)       VALUE 'borough'.
               10  FILLER          PIC X(14)       VALUE 'bury'.
               10  FILLER          PIC X(14)       VALUE 'view'.
               10  FILLER          PIC X(14)       VALUE 'port'.
               10  FILLER          PIC X(14)       VALUE 'mouth'.
               10  FILLER          PIC X(14)       VALUE 'stad'.
               10  FILLER          PIC X(14)       VALUE 'furt'.
               10  FILLER          PIC X(14)       VALUE 'chester'.
               10  FILLER          PIC X(14)       VALUE 'mouth'.
               10  FILLER          PIC X(14)       VALUE 'fort'.
               10  FILLER          PIC X(14)       VALUE 'haven'.
               10  FILLER          PIC X(14)       VALUE 'side'.
               10  FILLER          PIC X(14)       VALUE 'shire'.
           05  FILLER REDEFINES CITY-SUFFIX-OCCS.
               10  FILLER                          OCCURS 19
                                                   INDEXED CS-DX.
                   15  CITY-SUFFIX PIC X(14).

       01  BUILDING-NUMBER-FORMATS.
           05  BUILDING-NUMBER-FORMAT-CNT
                                   PIC S9(4)  COMP VALUE 3.
           05  BUILDING-NUMBER-FORMAT-OCCS.
               10  FILLER          PIC X(14)       VALUE '%####'.
               10  FILLER          PIC X(14)       VALUE '%###'.
               10  FILLER          PIC X(14)       VALUE '%##'.
           05  FILLER REDEFINES BUILDING-NUMBER-FORMAT-OCCS.
               10  FILLER                          OCCURS 3
                                                   INDEXED BNF-DX.
                   15  BUILDING-NUMBER-FORMAT
                                   PIC X(14).

       01  STREET-SUFFIXES.
           05  STREET-SUFFIX-CNT   PIC S9(4)  COMP VALUE 225.
           05  STREET-SUFFIX-OCCS.
               10  FILLER          PIC X(14)       VALUE 'Alley'.
               10  FILLER          PIC X(14)       VALUE 'Avenue'.
               10  FILLER          PIC X(14)       VALUE 'Branch'.
               10  FILLER          PIC X(14)       VALUE 'Bridge'.
               10  FILLER          PIC X(14)       VALUE 'Brook'.
               10  FILLER          PIC X(14)       VALUE 'Brooks'.
               10  FILLER          PIC X(14)       VALUE 'Burg'.
               10  FILLER          PIC X(14)       VALUE 'Burgs'.
               10  FILLER          PIC X(14)       VALUE 'Bypass'.
               10  FILLER          PIC X(14)       VALUE 'Camp'.
               10  FILLER          PIC X(14)       VALUE 'Canyon'.
               10  FILLER          PIC X(14)       VALUE 'Cape'.
               10  FILLER          PIC X(14)       VALUE 'Causeway'.
               10  FILLER          PIC X(14)       VALUE 'Center'.
               10  FILLER          PIC X(14)       VALUE 'Centers'.
               10  FILLER          PIC X(14)       VALUE 'Circle'.
               10  FILLER          PIC X(14)       VALUE 'Circles'.
               10  FILLER          PIC X(14)       VALUE 'Cliff'.
               10  FILLER          PIC X(14)       VALUE 'Cliffs'.
               10  FILLER          PIC X(14)       VALUE 'Club'.
               10  FILLER          PIC X(14)       VALUE 'Common'.
               10  FILLER          PIC X(14)       VALUE 'Corner'.
               10  FILLER          PIC X(14)       VALUE 'Corners'.
               10  FILLER          PIC X(14)       VALUE 'Course'.
               10  FILLER          PIC X(14)       VALUE 'Court'.
               10  FILLER          PIC X(14)       VALUE 'Courts'.
               10  FILLER          PIC X(14)       VALUE 'Cove'.
               10  FILLER          PIC X(14)       VALUE 'Coves'.
               10  FILLER          PIC X(14)       VALUE 'Creek'.
               10  FILLER          PIC X(14)       VALUE 'Crescent'.
               10  FILLER          PIC X(14)       VALUE 'Crest'.
               10  FILLER          PIC X(14)       VALUE 'Crossing'.
               10  FILLER          PIC X(14)       VALUE 'Crossroad'.
               10  FILLER          PIC X(14)       VALUE 'Curve'.
               10  FILLER          PIC X(14)       VALUE 'Dale'.
               10  FILLER          PIC X(14)       VALUE 'Dam'.
               10  FILLER          PIC X(14)       VALUE 'Divide'.
               10  FILLER          PIC X(14)       VALUE 'Drive'.
               10  FILLER          PIC X(14)       VALUE 'Drive'.
               10  FILLER          PIC X(14)       VALUE 'Drives'.
               10  FILLER          PIC X(14)       VALUE 'Estate'.
               10  FILLER          PIC X(14)       VALUE 'Estates'.
               10  FILLER          PIC X(14)       VALUE 'Expressway'.
               10  FILLER          PIC X(14)       VALUE 'Extension'.
               10  FILLER          PIC X(14)       VALUE 'Extensions'.
               10  FILLER          PIC X(14)       VALUE 'Fall'.
               10  FILLER          PIC X(14)       VALUE 'Falls'.
               10  FILLER          PIC X(14)       VALUE 'Ferry'.
               10  FILLER          PIC X(14)       VALUE 'Field'.
               10  FILLER          PIC X(14)       VALUE 'Fields'.
               10  FILLER          PIC X(14)       VALUE 'Flat'.
               10  FILLER          PIC X(14)       VALUE 'Flats'.
               10  FILLER          PIC X(14)       VALUE 'Ford'.
               10  FILLER          PIC X(14)       VALUE 'Fords'.
               10  FILLER          PIC X(14)       VALUE 'Forest'.
               10  FILLER          PIC X(14)       VALUE 'Forge'.
               10  FILLER          PIC X(14)       VALUE 'Forges'.
               10  FILLER          PIC X(14)       VALUE 'Fork'.
               10  FILLER          PIC X(14)       VALUE 'Forks'.
               10  FILLER          PIC X(14)       VALUE 'Fort'.
               10  FILLER          PIC X(14)       VALUE 'Freeway'.
               10  FILLER          PIC X(14)       VALUE 'Garden'.
               10  FILLER          PIC X(14)       VALUE 'Gardens'.
               10  FILLER          PIC X(14)       VALUE 'Gateway'.
               10  FILLER          PIC X(14)       VALUE 'Glen'.
               10  FILLER          PIC X(14)       VALUE 'Glens'.
               10  FILLER          PIC X(14)       VALUE 'Green'.
               10  FILLER          PIC X(14)       VALUE 'Greens'.
               10  FILLER          PIC X(14)       VALUE 'Grove'.
               10  FILLER          PIC X(14)       VALUE 'Groves'.
               10  FILLER          PIC X(14)       VALUE 'Harbor'.
               10  FILLER          PIC X(14)       VALUE 'Harbors'.
               10  FILLER          PIC X(14)       VALUE 'Haven'.
               10  FILLER          PIC X(14)       VALUE 'Heights'.
               10  FILLER          PIC X(14)       VALUE 'Highway'.
               10  FILLER          PIC X(14)       VALUE 'Hill'.
               10  FILLER          PIC X(14)       VALUE 'Hills'.
               10  FILLER          PIC X(14)       VALUE 'Hollow'.
               10  FILLER          PIC X(14)       VALUE 'Inlet'.
               10  FILLER          PIC X(14)       VALUE 'Inlet'.
               10  FILLER          PIC X(14)       VALUE 'Island'.
               10  FILLER          PIC X(14)       VALUE 'Island'.
               10  FILLER          PIC X(14)       VALUE 'Islands'.
               10  FILLER          PIC X(14)       VALUE 'Islands'.
               10  FILLER          PIC X(14)       VALUE 'Isle'.
               10  FILLER          PIC X(14)       VALUE 'Isle'.
               10  FILLER          PIC X(14)       VALUE 'Junction'.
               10  FILLER          PIC X(14)       VALUE 'Junctions'.
               10  FILLER          PIC X(14)       VALUE 'Key'.
               10  FILLER          PIC X(14)       VALUE 'Keys'.
               10  FILLER          PIC X(14)       VALUE 'Knoll'.
               10  FILLER          PIC X(14)       VALUE 'Knolls'.
               10  FILLER          PIC X(14)       VALUE 'Lake'.
               10  FILLER          PIC X(14)       VALUE 'Lakes'.
               10  FILLER          PIC X(14)       VALUE 'Land'.
               10  FILLER          PIC X(14)       VALUE 'Landing'.
               10  FILLER          PIC X(14)       VALUE 'Lane'.
               10  FILLER          PIC X(14)       VALUE 'Light'.
               10  FILLER          PIC X(14)       VALUE 'Lights'.
               10  FILLER          PIC X(14)       VALUE 'Loaf'.
               10  FILLER          PIC X(14)       VALUE 'Lock'.
               10  FILLER          PIC X(14)       VALUE 'Locks'.
               10  FILLER          PIC X(14)       VALUE 'Locks'.
               10  FILLER          PIC X(14)       VALUE 'Lodge'.
               10  FILLER          PIC X(14)       VALUE 'Lodge'.
               10  FILLER          PIC X(14)       VALUE 'Loop'.
               10  FILLER          PIC X(14)       VALUE 'Mall'.
               10  FILLER          PIC X(14)       VALUE 'Manor'.
               10  FILLER          PIC X(14)       VALUE 'Manors'.
               10  FILLER          PIC X(14)       VALUE 'Meadow'.
               10  FILLER          PIC X(14)       VALUE 'Meadows'.
               10  FILLER          PIC X(14)       VALUE 'Mews'.
               10  FILLER          PIC X(14)       VALUE 'Mill'.
               10  FILLER          PIC X(14)       VALUE 'Mills'.
               10  FILLER          PIC X(14)       VALUE 'Mission'.
               10  FILLER          PIC X(14)       VALUE 'Mission'.
               10  FILLER          PIC X(14)       VALUE 'Motorway'.
               10  FILLER          PIC X(14)       VALUE 'Mount'.
               10  FILLER          PIC X(14)       VALUE 'Mountain'.
               10  FILLER          PIC X(14)       VALUE 'Mountain'.
               10  FILLER          PIC X(14)       VALUE 'Mountains'.
               10  FILLER          PIC X(14)       VALUE 'Mountains'.
               10  FILLER          PIC X(14)       VALUE 'Neck'.
               10  FILLER          PIC X(14)       VALUE 'Orchard'.
               10  FILLER          PIC X(14)       VALUE 'Oval'.
               10  FILLER          PIC X(14)       VALUE 'Overpass'.
               10  FILLER          PIC X(14)       VALUE 'Park'.
               10  FILLER          PIC X(14)       VALUE 'Parks'.
               10  FILLER          PIC X(14)       VALUE 'Parkway'.
               10  FILLER          PIC X(14)       VALUE 'Parkways'.
               10  FILLER          PIC X(14)       VALUE 'Pass'.
               10  FILLER          PIC X(14)       VALUE 'Passage'.
               10  FILLER          PIC X(14)       VALUE 'Path'.
               10  FILLER          PIC X(14)       VALUE 'Pike'.
               10  FILLER          PIC X(14)       VALUE 'Pine'.
               10  FILLER          PIC X(14)       VALUE 'Pines'.
               10  FILLER          PIC X(14)       VALUE 'Place'.
               10  FILLER          PIC X(14)       VALUE 'Plain'.
               10  FILLER          PIC X(14)       VALUE 'Plains'.
               10  FILLER          PIC X(14)       VALUE 'Plains'.
               10  FILLER          PIC X(14)       VALUE 'Plaza'.
               10  FILLER          PIC X(14)       VALUE 'Plaza'.
               10  FILLER          PIC X(14)       VALUE 'Point'.
               10  FILLER          PIC X(14)       VALUE 'Points'.
               10  FILLER          PIC X(14)       VALUE 'Port'.
               10  FILLER          PIC X(14)       VALUE 'Port'.
               10  FILLER          PIC X(14)       VALUE 'Ports'.
               10  FILLER          PIC X(14)       VALUE 'Ports'.
               10  FILLER          PIC X(14)       VALUE 'Prairie'.
               10  FILLER          PIC X(14)       VALUE 'Prairie'.
               10  FILLER          PIC X(14)       VALUE 'Radial'.
               10  FILLER          PIC X(14)       VALUE 'Ramp'.
               10  FILLER          PIC X(14)       VALUE 'Ranch'.
               10  FILLER          PIC X(14)       VALUE 'Rapid'.
               10  FILLER          PIC X(14)       VALUE 'Rapids'.
               10  FILLER          PIC X(14)       VALUE 'Rest'.
               10  FILLER          PIC X(14)       VALUE 'Ridge'.
               10  FILLER          PIC X(14)       VALUE 'Ridges'.
               10  FILLER          PIC X(14)       VALUE 'River'.
               10  FILLER          PIC X(14)       VALUE 'Road'.
               10  FILLER          PIC X(14)       VALUE 'Road'.
               10  FILLER          PIC X(14)       VALUE 'Roads'.
               10  FILLER          PIC X(14)       VALUE 'Roads'.
               10  FILLER          PIC X(14)       VALUE 'Route'.
               10  FILLER          PIC X(14)       VALUE 'Row'.
               10  FILLER          PIC X(14)       VALUE 'Rue'.
               10  FILLER          PIC X(14)       VALUE 'Run'.
               10  FILLER          PIC X(14)       VALUE 'Shoal'.
               10  FILLER          PIC X(14)       VALUE 'Shoals'.
               10  FILLER          PIC X(14)       VALUE 'Shore'.
               10  FILLER          PIC X(14)       VALUE 'Shores'.
               10  FILLER          PIC X(14)       VALUE 'Skyway'.
               10  FILLER          PIC X(14)       VALUE 'Spring'.
               10  FILLER          PIC X(14)       VALUE 'Springs'.
               10  FILLER          PIC X(14)       VALUE 'Springs'.
               10  FILLER          PIC X(14)       VALUE 'Spur'.
               10  FILLER          PIC X(14)       VALUE 'Spurs'.
               10  FILLER          PIC X(14)       VALUE 'Square'.
               10  FILLER          PIC X(14)       VALUE 'Square'.
               10  FILLER          PIC X(14)       VALUE 'Squares'.
               10  FILLER          PIC X(14)       VALUE 'Squares'.
               10  FILLER          PIC X(14)       VALUE 'Station'.
               10  FILLER          PIC X(14)       VALUE 'Station'.
               10  FILLER          PIC X(14)       VALUE 'Stravenue'.
               10  FILLER          PIC X(14)       VALUE 'Stravenue'.
               10  FILLER          PIC X(14)       VALUE 'Stream'.
               10  FILLER          PIC X(14)       VALUE 'Stream'.
               10  FILLER          PIC X(14)       VALUE 'Street'.
               10  FILLER          PIC X(14)       VALUE 'Street'.
               10  FILLER          PIC X(14)       VALUE 'Streets'.
               10  FILLER          PIC X(14)       VALUE 'Summit'.
               10  FILLER          PIC X(14)       VALUE 'Summit'.
               10  FILLER          PIC X(14)       VALUE 'Terrace'.
               10  FILLER          PIC X(14)       VALUE 'Throughway'.
               10  FILLER          PIC X(14)       VALUE 'Trace'.
               10  FILLER          PIC X(14)       VALUE 'Track'.
               10  FILLER          PIC X(14)       VALUE 'Trafficway'.
               10  FILLER          PIC X(14)       VALUE 'Trail'.
               10  FILLER          PIC X(14)       VALUE 'Trail'.
               10  FILLER          PIC X(14)       VALUE 'Tunnel'.
               10  FILLER          PIC X(14)       VALUE 'Tunnel'.
               10  FILLER          PIC X(14)       VALUE 'Turnpike'.
               10  FILLER          PIC X(14)       VALUE 'Turnpike'.
               10  FILLER          PIC X(14)       VALUE 'Underpass'.
               10  FILLER          PIC X(14)       VALUE 'Union'.
               10  FILLER          PIC X(14)       VALUE 'Unions'.
               10  FILLER          PIC X(14)       VALUE 'Valley'.
               10  FILLER          PIC X(14)       VALUE 'Valleys'.
               10  FILLER          PIC X(14)       VALUE 'Via'.
               10  FILLER          PIC X(14)       VALUE 'Viaduct'.
               10  FILLER          PIC X(14)       VALUE 'View'.
               10  FILLER          PIC X(14)       VALUE 'Views'.
               10  FILLER          PIC X(14)       VALUE 'Village'.
               10  FILLER          PIC X(14)       VALUE 'Village'.
               10  FILLER          PIC X(14)       VALUE 'Villages'.
               10  FILLER          PIC X(14)       VALUE 'Ville'.
               10  FILLER          PIC X(14)       VALUE 'Vista'.
               10  FILLER          PIC X(14)       VALUE 'Vista'.
               10  FILLER          PIC X(14)       VALUE 'Walk'.
               10  FILLER          PIC X(14)       VALUE 'Walks'.
               10  FILLER          PIC X(14)       VALUE 'Wall'.
               10  FILLER          PIC X(14)       VALUE 'Way'.
               10  FILLER          PIC X(14)       VALUE 'Ways'.
               10  FILLER          PIC X(14)       VALUE 'Well'.
               10  FILLER          PIC X(14)       VALUE 'Wells'.
           05  FILLER REDEFINES STREET-SUFFIX-OCCS.
               10  FILLER                          OCCURS 225
                                                   INDEXED SS-DX.
                   15  STREET-SUFFIX
                                   PIC X(14).

       01  SECONDARY-ADDRESS-FORMATS.
           05  SECONDARY-ADDRESS-FORMAT-CNT
                                   PIC S9(4)  COMP VALUE 2.
           05  SECONDARY-ADDRESS-FORMAT-OCCS.
               10  FILLER          PIC X(14)       VALUE 'Apt %##'.
               10  FILLER          PIC X(14)       VALUE 'Ste %##'.
           05  FILLER REDEFINES SECONDARY-ADDRESS-FORMAT-OCCS.
               10  FILLER                          OCCURS 2
                                                   INDEXED PF-DX.
                   15  SECONDARY-ADDRESS-FORMAT
                                   PIC X(14).

       01  POSTCODE-FORMATS.
           05  POSTCODE-FORMAT-CNT
                                   PIC S9(4)  COMP VALUE 2.
           05  POSTCODE-FORMAT-OCCS.
               10  FILLER          PIC X(14)       VALUE '#####'.
               10  FILLER          PIC X(14)       VALUE '#####-####'.
           05  FILLER REDEFINES POSTCODE-FORMAT-OCCS.
               10  FILLER                          OCCURS 2
                                                   INDEXED PF-DX.
                   15  POSTCODE-FORMAT
                                   PIC X(14).

       01  STATES.
           05  STATE-CNT           PIC S9(4)  COMP VALUE 50.
           05  STATE-OCCS.
               10  FILLER          PIC X(14)     VALUE 'Alabama'.
               10  FILLER          PIC X(14)     VALUE 'Alaska'.
               10  FILLER          PIC X(14)     VALUE 'Arizona'.
               10  FILLER          PIC X(14)     VALUE 'Arkansas'.
               10  FILLER          PIC X(14)     VALUE 'California'.
               10  FILLER          PIC X(14)     VALUE 'Colorado'.
               10  FILLER          PIC X(14)     VALUE 'Connecticut'.
               10  FILLER          PIC X(14)     VALUE 'Delaware'.
               10  FILLER          PIC X(14)     VALUE 'Florida'.
               10  FILLER          PIC X(14)     VALUE 'Georgia'.
               10  FILLER          PIC X(14)     VALUE 'Hawaii'.
               10  FILLER          PIC X(14)     VALUE 'Idaho'.
               10  FILLER          PIC X(14)     VALUE 'Illinois'.
               10  FILLER          PIC X(14)     VALUE 'Indiana'.
               10  FILLER          PIC X(14)     VALUE 'Iowa'.
               10  FILLER          PIC X(14)     VALUE 'Kansas'.
               10  FILLER          PIC X(14)     VALUE 'Kentucky'.
               10  FILLER          PIC X(14)     VALUE 'Louisiana'.
               10  FILLER          PIC X(14)     VALUE 'Maine'.
               10  FILLER          PIC X(14)     VALUE 'Maryland'.
               10  FILLER          PIC X(14)     VALUE 'Massachusetts'.
               10  FILLER          PIC X(14)     VALUE 'Michigan'.
               10  FILLER          PIC X(14)     VALUE 'Minnesota'.
               10  FILLER          PIC X(14)     VALUE 'Mississippi'.
               10  FILLER          PIC X(14)     VALUE 'Missouri'.
               10  FILLER          PIC X(14)     VALUE 'Montana'.
               10  FILLER          PIC X(14)     VALUE 'Nebraska'.
               10  FILLER          PIC X(14)     VALUE 'Nevada'.
               10  FILLER          PIC X(14)     VALUE 'New Hampshire'.
               10  FILLER          PIC X(14)     VALUE 'New Jersey'.
               10  FILLER          PIC X(14)     VALUE 'New Mexico'.
               10  FILLER          PIC X(14)     VALUE 'New York'.
               10  FILLER          PIC X(14)     VALUE 'North Carolina'.
               10  FILLER          PIC X(14)     VALUE 'North Dakota'.
               10  FILLER          PIC X(14)     VALUE 'Ohio'.
               10  FILLER          PIC X(14)     VALUE 'Oklahoma'.
               10  FILLER          PIC X(14)     VALUE 'Oregon'.
               10  FILLER          PIC X(14)     VALUE 'Pennsylvania'.
               10  FILLER          PIC X(14)     VALUE 'Rhode Island'.
               10  FILLER          PIC X(14)     VALUE 'South Carolina'.
               10  FILLER          PIC X(14)     VALUE 'South Dakota'.
               10  FILLER          PIC X(14)     VALUE 'Tennessee'.
               10  FILLER          PIC X(14)     VALUE 'Texas'.
               10  FILLER          PIC X(14)     VALUE 'Utah'.
               10  FILLER          PIC X(14)     VALUE 'Vermont'.
               10  FILLER          PIC X(14)     VALUE 'Virginia'.
               10  FILLER          PIC X(14)     VALUE 'Washington'.
               10  FILLER          PIC X(14)     VALUE 'West Virginia'.
               10  FILLER          PIC X(14)     VALUE 'Wisconsin'.
               10  FILLER          PIC X(14)     VALUE 'Wyoming'.
           05  FILLER REDEFINES STATE-OCCS.
               10  FILLER                          OCCURS 50
                                                   INDEXED ST-DX.
                   15  STATE       PIC X(14).

       01  STATES-ABBR.
           05  STATE-ABBR-CNT      PIC S9(4)  COMP VALUE 51.
           05  STATE-ABBR-OCCS.
               10  FILLER          PIC X(14)       VALUE 'AL'.
               10  FILLER          PIC X(14)       VALUE 'AK'.
               10  FILLER          PIC X(14)       VALUE 'AZ'.
               10  FILLER          PIC X(14)       VALUE 'AR'.
               10  FILLER          PIC X(14)       VALUE 'CA'.
               10  FILLER          PIC X(14)       VALUE 'CO'.
               10  FILLER          PIC X(14)       VALUE 'CT'.
               10  FILLER          PIC X(14)       VALUE 'DE'.
               10  FILLER          PIC X(14)       VALUE 'DC'.
               10  FILLER          PIC X(14)       VALUE 'FL'.
               10  FILLER          PIC X(14)       VALUE 'GA'.
               10  FILLER          PIC X(14)       VALUE 'HI'.
               10  FILLER          PIC X(14)       VALUE 'ID'.
               10  FILLER          PIC X(14)       VALUE 'IL'.
               10  FILLER          PIC X(14)       VALUE 'IN'.
               10  FILLER          PIC X(14)       VALUE 'IA'.
               10  FILLER          PIC X(14)       VALUE 'KS'.
               10  FILLER          PIC X(14)       VALUE 'KY'.
               10  FILLER          PIC X(14)       VALUE 'LA'.
               10  FILLER          PIC X(14)       VALUE 'ME'.
               10  FILLER          PIC X(14)       VALUE 'MD'.
               10  FILLER          PIC X(14)       VALUE 'MA'.
               10  FILLER          PIC X(14)       VALUE 'MI'.
               10  FILLER          PIC X(14)       VALUE 'MN'.
               10  FILLER          PIC X(14)       VALUE 'MS'.
               10  FILLER          PIC X(14)       VALUE 'MO'.
               10  FILLER          PIC X(14)       VALUE 'MT'.
               10  FILLER          PIC X(14)       VALUE 'NE'.
               10  FILLER          PIC X(14)       VALUE 'NV'.
               10  FILLER          PIC X(14)       VALUE 'NH'.
               10  FILLER          PIC X(14)       VALUE 'NJ'.
               10  FILLER          PIC X(14)       VALUE 'NM'.
               10  FILLER          PIC X(14)       VALUE 'NY'.
               10  FILLER          PIC X(14)       VALUE 'NC'.
               10  FILLER          PIC X(14)       VALUE 'ND'.
               10  FILLER          PIC X(14)       VALUE 'OH'.
               10  FILLER          PIC X(14)       VALUE 'OK'.
               10  FILLER          PIC X(14)       VALUE 'OR'.
               10  FILLER          PIC X(14)       VALUE 'PA'.
               10  FILLER          PIC X(14)       VALUE 'RI'.
               10  FILLER          PIC X(14)       VALUE 'SC'.
               10  FILLER          PIC X(14)       VALUE 'SD'.
               10  FILLER          PIC X(14)       VALUE 'TN'.
               10  FILLER          PIC X(14)       VALUE 'TX'.
               10  FILLER          PIC X(14)       VALUE 'UT'.
               10  FILLER          PIC X(14)       VALUE 'VT'.
               10  FILLER          PIC X(14)       VALUE 'VA'.
               10  FILLER          PIC X(14)       VALUE 'WA'.
               10  FILLER          PIC X(14)       VALUE 'WV'.
               10  FILLER          PIC X(14)       VALUE 'WI'.
               10  FILLER          PIC X(14)       VALUE 'WY'.
           05  FILLER REDEFINES STATE-ABBR-OCCS.
               10  FILLER                          OCCURS 51
                                                   INDEXED SA-DX.
                   15  STATE-ABBR  PIC X(14).


       01  STATES-POSTCODE.
           05  STATE-POSTCODE-CNT  PIC S9(4)  COMP VALUE 51.
           05  STATE-POSTCODE-OCCS.
               10  FILLER          PIC X(14)     VALUE 'AL 35004 36925'.
               10  FILLER          PIC X(14)     VALUE 'AK 99501 99950'.
               10  FILLER          PIC X(14)     VALUE 'AZ 85001 86556'.
               10  FILLER          PIC X(14)     VALUE 'AR 71601 72959'.
               10  FILLER          PIC X(14)     VALUE 'CA 90001 96162'.
               10  FILLER          PIC X(14)     VALUE 'CO 80001 81658'.
               10  FILLER          PIC X(14)     VALUE 'CT 06001 06389'.
               10  FILLER          PIC X(14)     VALUE 'DE 19701 19980'.
               10  FILLER          PIC X(14)     VALUE 'DC 20001 20039'.
               10  FILLER          PIC X(14)     VALUE 'FL 32004 34997'.
               10  FILLER          PIC X(14)     VALUE 'GA 30001 31999'.
               10  FILLER          PIC X(14)     VALUE 'HI 96701 96898'.
               10  FILLER          PIC X(14)     VALUE 'ID 83201 83876'.
               10  FILLER          PIC X(14)     VALUE 'IL 60001 62999'.
               10  FILLER          PIC X(14)     VALUE 'IN 46001 47997'.
               10  FILLER          PIC X(14)     VALUE 'IA 50001 52809'.
               10  FILLER          PIC X(14)     VALUE 'KS 66002 67954'.
               10  FILLER          PIC X(14)     VALUE 'KY 40003 42788'.
               10  FILLER          PIC X(14)     VALUE 'LA 70001 71232'.
               10  FILLER          PIC X(14)     VALUE 'ME 03901 04992'.
               10  FILLER          PIC X(14)     VALUE 'MD 20331 20331'.
               10  FILLER          PIC X(14)     VALUE 'MA 01001 02791'.
               10  FILLER          PIC X(14)     VALUE 'MI 48001 49971'.
               10  FILLER          PIC X(14)     VALUE 'MN 55001 56763'.
               10  FILLER          PIC X(14)     VALUE 'MS 38601 39776'.
               10  FILLER          PIC X(14)     VALUE 'MO 63001 65899'.
               10  FILLER          PIC X(14)     VALUE 'MT 59001 59937'.
               10  FILLER          PIC X(14)     VALUE 'NE 68001 68118'.
               10  FILLER          PIC X(14)     VALUE 'NV 88901 89883'.
               10  FILLER          PIC X(14)     VALUE 'NH 03031 03897'.
               10  FILLER          PIC X(14)     VALUE 'NJ 07001 08989'.
               10  FILLER          PIC X(14)     VALUE 'NM 87001 88441'.
               10  FILLER          PIC X(14)     VALUE 'NY 10001 14905'.
               10  FILLER          PIC X(14)     VALUE 'NC 27006 28909'.
               10  FILLER          PIC X(14)     VALUE 'ND 58001 58856'.
               10  FILLER          PIC X(14)     VALUE 'OH 43001 45999'.
               10  FILLER          PIC X(14)     VALUE 'OK 73001 73199'.
               10  FILLER          PIC X(14)     VALUE 'OR 97001 97920'.
               10  FILLER          PIC X(14)     VALUE 'PA 15001 19640'.
               10  FILLER          PIC X(14)     VALUE 'RI 02801 02940'.
               10  FILLER          PIC X(14)     VALUE 'SC 29001 29948'.
               10  FILLER          PIC X(14)     VALUE 'SD 57001 57799'.
               10  FILLER          PIC X(14)     VALUE 'TN 37010 38589'.
               10  FILLER          PIC X(14)     VALUE 'TX 73301 73301'.
               10  FILLER          PIC X(14)     VALUE 'UT 84001 84784'.
               10  FILLER          PIC X(14)     VALUE 'VT 05001 05495'.
               10  FILLER          PIC X(14)     VALUE 'VA 20040 20041'.
               10  FILLER          PIC X(14)     VALUE 'WA 98001 99403'.
               10  FILLER          PIC X(14)     VALUE 'WV 24701 26886'.
               10  FILLER          PIC X(14)     VALUE 'WI 53001 54990'.
               10  FILLER          PIC X(14)     VALUE 'WY 82001 83128'.
           05  FILLER REDEFINES STATE-POSTCODE-OCCS.
               10  FILLER                          OCCURS 51
                                                   INDEXED SP-DX.
                   15  STATE-ABBR-PC
                                   PIC X(2).
                   15  FILLER      PIC X.
                   15  STATE-POSTCODE-MIN
                                   PIC 9(5).
                   15  FILLER      PIC X.
                   15  STATE-POSTCODE-MAX
                                   PIC 9(5).

       01  TERRITORIES-ABBR.
           05  TERRITORY-ABBR-CNT  PIC S9(4)  COMP VALUE 8.
           05  TERRITORY-ABBR-OCCS.
               10  FILLER          PIC X(14)       VALUE 'AS'.
               10  FILLER          PIC X(14)       VALUE 'FM'.
               10  FILLER          PIC X(14)       VALUE 'GU'.
               10  FILLER          PIC X(14)       VALUE 'MH'.
               10  FILLER          PIC X(14)       VALUE 'MP'.
               10  FILLER          PIC X(14)       VALUE 'PW'.
               10  FILLER          PIC X(14)       VALUE 'PR'.
               10  FILLER          PIC X(14)       VALUE 'VI'.
           05  FILLER REDEFINES TERRITORY-ABBR-OCCS.
               10  FILLER                          OCCURS 8
                                                   INDEXED TA-DX.
                   15  TERRITORY-ABBR
                                   PIC X(14).

       01  MILITARY-STATES-ABBR.
           05  MILITARY-STATE-ABBR-CNT
                                   PIC S9(4)  COMP VALUE 3.
           05  MILITARY-STATE-ABBR-OCCS.
               10  FILLER          PIC X(14)       VALUE 'AA'.
               10  FILLER          PIC X(14)       VALUE 'AE'.
               10  FILLER          PIC X(14)       VALUE 'AP'.
           05  FILLER REDEFINES MILITARY-STATE-ABBR-OCCS.
               10  FILLER                          OCCURS 3
                                                   INDEXED MSA-DX.
                   15  MILITARY-STATE-ABBR
                                   PIC X(14).

       01  MILITARY-SHIP-PREFIXES.
           05  MILITARY-SHIP-PREFIX-CNT
                                   PIC S9(4)  COMP VALUE 4.
           05  MILITARY-SHIP-PREFIX-OCCS.
               10  FILLER          PIC X(14)       VALUE 'USS'.
               10  FILLER          PIC X(14)       VALUE 'USNS'.
               10  FILLER          PIC X(14)       VALUE 'USNV'.
               10  FILLER          PIC X(14)       VALUE 'USCGC'.
           05  FILLER REDEFINES MILITARY-SHIP-PREFIX-OCCS.
               10  FILLER                          OCCURS 4
                                                   INDEXED MSP-DX.
                   15  MILITARY-SHIP-PREFIX
                                   PIC X(14).

       01  MILITARY-APO-FORMATS.
           05  MILITARY-APO-FORMAT-CNT
                                   PIC S9(4)  COMP VALUE 2.
           05  MILITARY-APO-FORMAT-OCCS.
               10  FILLER          PIC X(14)       VALUE 'PSC %###'.
               10  FILLER          PIC X(14)       VALUE 'Box %###'.
           05  FILLER REDEFINES MILITARY-APO-FORMAT-OCCS.
               10  FILLER                          OCCURS 2
                                                   INDEXED MAF-DX.
                   15  MILITARY-APO-FORMAT
                                   PIC X(14).

       01  MILITARY-DPO-FORMATS.
           05  MILITARY-DPO-FORMAT-CNT
                                   PIC S9(4)  COMP VALUE 2.
           05  MILITARY-DPO-FORMAT-OCCS.
               10  FILLER          PIC X(14)       VALUE 'Unit %###'.
               10  FILLER          PIC X(14)       VALUE 'Box %###'.
           05  FILLER REDEFINES MILITARY-DPO-FORMAT-OCCS.
               10  FILLER                          OCCURS 2
                                                   INDEXED MDF-DX.
                   15  MILITARY-DPO-FORMAT
                                   PIC X(14).
