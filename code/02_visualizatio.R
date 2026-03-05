#R code for visualizing satellite images
library(terra)
library(imageRy)

#pacchetti utilizzati
#install.packages("viridis")

#tutte le funzioni all'interno di imagery iniziano con "im."

#listing data
im.list()

#? per spiegazione funzione
?im.import()

#"sentinel.dolomites.b2.tif"  da risultato<- im.list()
b2<-im.import("sentinel.dolomites.b2.tif")

#changing colors
#per scegliere colori cercare "R palette su internet"
#c perchè i colori vanno concatenati
#(100)<- sono le sfumature 
cl<-colorRampPalette(c("#DEB887", "#98F5FF", "#7FFF00"))(100)
plot(b2,col=cl)
#avrò così una mappa con i colori e le sfuature da me scelti 

#creare palette veloci attarversi pacchetto "viridis"

install.packages("viridis")
install.packages("viridisLite")

#viridis palette
plot(b2,col=inferno(100))
plot(b2,col=mako(100))

#exercise:plot band 2 w greyscale palette

plot(b2,col=c("dark gray","gray","light gray"))(100)
plot(b2,col=c("#454545","#A8A8A8","#EDEDED"))(100)

#funzione "par" pensata per una funzione di grafici, per fare multiframe (mf)
#1,2 vanno concatebnati con c perchè fanno parte della stessa funzione
par(mfrow=c(1,2))
plot(b2,col=c("#454545","#A8A8A8","#EDEDED"))(100)
plot(b2,col=cl)

#"dev" serve per fare controllo del device, se metto off spengo il device
dev.off
?im.multiframe
plot(b2,col=c("#454545","#A8A8A8","#EDEDED"))(100)
plot(b2,col=cl)

#?im.multiframe non funzia boh, in caso par(mfrow=c(1,2))

im.list()
b2<-im.import("sentinel.dolomites.b2.tif")
b8<-im.import("sentinel.dolomites.b8.tif")
b3<-im.import("sentinel.dolomites.b3.tif")
b4<-im.import("sentinel.dolomites.b4.tif")

cl<-colorRampPalette(c("#DEB887", "#98F5FF", "#7FFF00"))(100)
plot(b2,col=cl)
plot(b2,col=inferno(100))
plot(b2,col=mako(100))

im.multiframe(2,2)

plot(b2,col=inferno(100))
plot(b3,col=inferno(100))
plot(b4,col=inferno(100))
plot(b8,col=inferno(100))

sentinel<-c(b2,b3,b4,b8)
plot(sentinel)
plot(sentinel, col=inferno(100))

#ottenere informazioni
sentinel
names(sentinel)
b2 #info su sistemi di riferiento etc, tipo  WGS 84 / UTM zone 32N (EPSG:32632)
#UTM universale trasversa mercatore, EPSG eurpan petroleum survey group<-codice per il sistema di riferimentow

#subset di sentinel
plot(sentinel$sentinel.dolomites.b8)   #boh a me non va

#layer1=b2 layer2=b3 layer3=b4 layer4=b8
plot(sentinel[[4]])
plot(sentinel[[2]])

