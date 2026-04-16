library(terra)
library(imageRy)

setwd("~/Desktop/immagini_telerilevamento")
getwd()

richat<-rast("richatstructure_oli_20260306.jpg")

richat<-flip(richat)

plot(richat)

png("figura.png")
plot(richat)
dev.off()

im.multiframe(2,1)
plot(richat[[1]])
plot(richat[[2]])
dev.off()

#per fare istogrammi dele bande chiedi a chat



png("istogrammi_rgb.png", width=800, height=1200)

im.multiframe(3,1)

colori <- c("red", "green", "blue")
nomi <- c("Red band", "Green band", "Blue band")

for(i in 1:3){
  hist(richat[[i]],
       main = nomi[i],
       col = colori[i],
       xlab = "Valori pixel")
}

dev.off()

