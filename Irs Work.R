library(readr)
library(dplyr)

irs2015 <- read_csv("C:/Users/Eric VonDohlen/Downloads/15zpallagi.csv")


sample_for_test <- filter(irs2015, !zipcode=='00000') %>% select(zipcode, N1, agi_stub, A00100)



agi_zip_bucket <- sample_for_test %>% group_by(zipcode, agi_stub) %>% mutate(avg_stub_agi=(A00100/N1))





irs_example <- sample_for_test %>% group_by(zipcode) %>% summarise(n=n(), count=sum(N1), total_agi=sum(A00100)) 
irs_example <- mutate(irs_example, avg_agi= total_agi / count) %>% arrange(desc(avg_agi))


test_1 <- merge(agi_zip_bucket,irs_example,by="zipcode", all.x=T, all.y=F)
