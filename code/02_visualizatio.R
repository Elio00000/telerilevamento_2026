#R code for visualizing satellite images
library(terra)
library(imageRy)

library(ggplot2)

library(ggrdiges)

#pacchetti utilizzati
#install.packages("viridis")
#install.packages("ggrdiges")
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

#per multiframe <- mfrow... oppure im.multiframe oppure
# creare uno stack ossia un'immagin sagtellitare, si mette tutto inseme, utulizzandole bande come vettore (funz. c)
sentinel<-c(b2,b3,b4,b8)
#layer 1= blue 
#2=b3=verde
#3=b4=red
#4=b8=NIR (near infra red)

sentinel

#se serve solo una 
plot(sentinel[[4]])


library(ggplot2)

#altro modo per avere più grafici
#install.packages("patchwork")

im.ggplot(b8)
#a questo punto 4 modi per fare un multiframe 

#––––––

#RBG plotting

#da sentinel<-c(b2,b3,b4,b8)
#layer 1= blue 
#2=b3=green
#3=b4=red
#4=b8=NIR (near infra red)

im.plotRGB(sentinel, r=3, g=2, b=1)

#piante sane e non sane riflettono la luce in modo diverso, il rosso ed il blu solitamente assorbiti vengono riflessi
#inoltre cambia la qt. di NIR, piante sane riflettono molto, piante malate poco

#essendoci solo 3 posti si toglie il blu spostando tutto i uno
im.plotRGB(sentinel, r=4, g=3, b=2)

#la parte bianca la centro sono rocce bianche che riflettono tutte le lunghezze d'onda, uguale a prescindere dalla composizione delle lunghezze d'onda

#questa inversione conta poco, perchè le bande del visibile sono correlate tra loro
im.plotRGB(sentinel, r=3, g=4, b=2)

im.multiframe(1,2)
im.plotRGB(sentinel, r=3, g=4, b=2)
im.plotRGB(sentinel, r=4, g=3, b=2)

im.plotRGB(sentinel, r=2, g=3, b=4)

#grafico correlazioni 
pairs(sentinel)

#nel plottaggi abbiano utilizzato la funzione im.plotRGB che si basa su una funzione di "terra" (plotRGB)
#plotting RGB via terra
plotRGB(sentinel, r=4, g=3, b=2)
#in questo caso non funziona in quanto la riflettanza non sarà mai in nesun punto totale (=1) o 0, quindi
#strech lineare,es rif vera tra 20 e 60 -> 20=0, 60=1 (tot)
plotRGB(sentinel, r=4, g=3, b=2, strech="lin")
oppure istogram strech, stesso concetto ma con barre sotto "retta" per esprimere meglio valori intemedi, utile per discriminare oggetti molto "piccoli"
#o poco individuabili

plotRGB(sentinel, r=4, g=3, b=2, strech="hist")

im.multiframe(1,2)
plotRGB(sentinel, r=4, g=3, b=2, stretch="lin")
plotRGB(sentinel, r=4, g=3, b=2, stretch="hist")
#il secondo da le stesse informazioni enfatizzando le differenze 

#quando si utilizza il visibile si chiamano colori naturali, quando invece si utilizza l'infrarosso IR vengono detti false color
#inoltre si può ulteriormente semplificare es. 
plotRGB(3,1,2) #colori naturali


#####
im.list()
####import data
#nvdi biomassa di una certa area attraverso nearinfrared è assorbito

nvdi <- im.import("Sentinel2_NDVI")

hist(nvdi)
#distribuzione di frequenza per curve continue

# ?im.rdigeline-> immagine, scala , palette
im.rdigeline(nvdi,scale=1, palette=viridis)
names(nvdi)<-c("02feb","05may","08aug","11nov")
#es
im.rdigeline(nvdi,scale=2, palette=viridis)

#scatter plot
plot(nvdi[[1]],nvdi[[2]])
#aggiungere linea
abline(0,1,col="red")

plot(nvdi[[1]],nvdi[[2]],xlim=c(-0.3,0.9),ylim=c(-0.3,0.9))
abline(0,1,col="red")
#i punti sopra alla linea sono più alti a maggi oche a febbraio
#questo era unnesempio di dati multi-trmporali





