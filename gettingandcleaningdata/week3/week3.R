acs <- read.csv("C:\\Users\\rnield\\AppData\\Local\\Temp\\RtmpOk8Avu\\data32c45bffdb8")
#agricultureLogical <- subset(acs, AGS == 6 & ACR == 3)

agricultureLogical <- (acs$AGS == 6 & acs$ACR == 3)
which(agricultureLogical)
