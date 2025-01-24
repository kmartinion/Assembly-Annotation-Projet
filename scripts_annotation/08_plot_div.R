# Charger les bibliothèques
library(ggplot2)
library(reshape2)
library(cowplot)
library(RColorBrewer)
library(readxl)


file_path <- "C:/Users/hansd/OneDrive/Bureau/assembly.fasta.mod.out.landscape.Div.Rname.xlsx"


df <- read_excel(file_path, sheet = 1)


df_melted <- melt(df, id.vars = c("Rname", "Rclass", "Rfam"), 
                  variable.name = "distance", 
                  value.name = "value")

ggplot(df_melted, aes(fill = Rfam, x = distance, weight = value / 1000000)) +
  geom_bar() +
  cowplot::theme_cowplot() +  # Utiliser un thème minimaliste
  scale_fill_brewer(palette = "Paired") +  # Palette de couleurs
  xlab("Distance") +  # Label pour l'axe X
  ylab("Sequence (Mbp)") +  # Label pour l'axe Y
  theme(axis.text.x = element_text(angle = 90, vjust = 1, size = 9, hjust = 1),  # Ajuster les étiquettes de l'axe X
        plot.title = element_text(hjust = 0.5))  # Centrer le titre du graphique


ggsave("graphique_TE_distance.pdf", width = 10, height = 6)

