# Titolo progetto esame, ma mancano le immagini, da ripassare

L'area di studio sarà quella scelta 

mauritania 
 


## Pacchetti utilizzati:
per questo esame ho utilizzato i seguenti pacchetti:

```r
library(terra) #pacchetto per satellite
ibrary(imageRy)
```
## Importazione dati
i dati sono stati scaricati da erth observatory: https://science.nasa.gov/earth/earth-observatory/eyeing-the-richat-structure/

i dati sono stati scaricati da [erth observatory](https://science.nasa.gov/earth/earth-observatory/eyeing-the-richat-structure/)

il codice utilizzato è il seguente; prima di tutto si setta la workong directory

```r
setwd("~/immagini_telerilevamento/")
getwd()
```

per importare le immagini è stata uttilizzata la funzione `rast()` del pacchetto `terra`

```r
richat<-rast("richatstructure_oli_20260306.jpg")

richat<-flip(richat)

plot(richat)
```

## istogrammi con chat e "ciclo" for

```r
colori <- c("red", "green", "blue")
nomi <- c("Red band", "Green band", "Blue band")

for(i in 1:3){
  hist(richat[[i]],
       main = nomi[i],
       col = colori[i],
       xlab = "Valori pixel")
```



