library(data.table)
library(ggplot2)


#### Plots for showing temporal DOM Change for the flow regimes ####
variables <- c("PC1", "PC2", "beta.alpha")
monthly_mean_variables <-  PCA_results[,  lapply(.SD, mean, na.rm = TRUE),
                                       .SDcols = variables,
                                       by = .(campaign, groups.x)]

river_mean <- PCA_results[, lapply(.SD, mean, na.rm = TRUE),
                        .SDcols = variables,
                        by = .(site, Class, groups.x, alteration)]

river_sd <- PCA_results[, lapply(.SD, sd, na.rm = TRUE),
                         .SDcols = variables,
                         by = .(site, Class, groups.x, alteration)]

# z-score standardised pca values for PC1 PC2 and beta.alpha( calculated from X-Mean/SD formula)
pca_PC1 <- cbind(PC1_norm = (PCA_results$PC1 - river_mean$PC1[match(PCA_results$site, river_mean$site)] ) / (river_sd$PC1[match(PCA_results$site, river_mean$site)] ),
               PCA_results)

pca_PC2 <- cbind(PC2_norm = (PCA_results$PC2 - river_mean$PC2[match(PCA_results$site, river_mean$site)] ) / (river_sd$PC2[match(PCA_results$site, river_mean$site)] ),
               PCA_results)

pca_beta_alpha <- cbind(beta_alpha_norm = (PCA_results$beta.alpha - river_mean$beta.alpha[match(PCA_results$site, river_mean$site)]) / (river_sd$beta.alpha[match(PCA_results$site, river_mean$site)] ),
                      PCA_results)

pca_PC1[, mean_PC1_norm := mean(PC1_norm), by = .(campaign, groups.x)]

med_PC1 <- ggplot(pca_PC1[Class == "Mediterranean"], aes(x = campaign, y = PC1)) +
  geom_line(aes(group = site, color = groups.x), lwd = 0.3) +
  geom_point(aes(group = site, shape = groups.x, fill = groups.x), size = 2, color = "black") +
  geom_line(data = monthly_mean_variables[groups.x == "MedAlt" | groups.x == "MedNat"],
            aes(x = campaign, y = PC1, group = groups.x, color = groups.x), lwd = 1.3) +
  scale_shape_manual(values = c(25, 24)) +
  scale_color_manual(values = c("#F5CB7D", "#F09E41")) +
  scale_fill_manual(values = c("#F5CB7D", "#F09E41")) +
  scale_x_discrete(limits = c("Feb", "Apr", "May", "Aug", "Oct", "Dec"),
                   labels = c("Feb", "Apr", "May", "Aug", "Oct", "Dec")) +
  theme_pca() +
  theme(axis.title.x = element_blank()) +
  ylab("PC1 Scores")

pdf("output/plots/med_PC1.pdf", width = 3, height = 3)
plot(med_PC1)
dev.off()

temp_PC1 <- ggplot(PCA_results[Class == "Temperate"], aes(x = campaign, y = PC1)) +
  geom_line(aes(group = site, color = groups.x), lwd = 0.3) +
  geom_point(aes(group = site, shape = groups.x, fill = groups.x), size = 2, color = "black") +
  geom_line(data = monthly_mean_variables[groups.x == "TempAlt" | groups.x == "TempNat"],
            aes(x = campaign, y = PC1, group = groups.x, color = groups.x), lwd = 1.3) +
  scale_shape_manual(values = c(23, 22)) +
  scale_color_manual(values = c("#B4DCED", "#6996D1")) +
  scale_fill_manual(values = c("#B4DCED", "#6996D1")) +
  scale_x_discrete(limits = c("Feb", "Apr", "May", "Aug", "Oct", "Dec"),
                   labels = c("Feb", "Apr", "May", "Aug", "Oct", "Dec")) +
  theme_pca() +
  theme(axis.title.x = element_blank()) +
  ylab("PC1 Scores")

pdf("output/plots/temp_PC1.pdf", width = 3, height = 3)
plot(temp_PC1)
dev.off()

med_PC2 <- ggplot(PCA_results[Class == "Mediterranean"], aes(x = campaign, y = PC2)) +
  geom_line(aes(group = site, color = groups.x), lwd = 0.3) +
  geom_point(aes(group = site, shape = groups.x, fill = groups.x), size = 2, color = "black") +
  geom_line(data = monthly_mean_variables[groups.x == "MedAlt" | groups.x == "MedNat"],
            aes(x = campaign, y = PC2, group = groups.x, color = groups.x), lwd = 1.3) +
  scale_shape_manual(values = c(25, 24)) +
  scale_color_manual(values = c("#F5CB7D", "#F09E41")) +
  scale_fill_manual(values = c("#F5CB7D", "#F09E41")) +
  scale_x_discrete(limits = c("Feb", "Apr", "May", "Aug", "Oct", "Dec"),
                   labels = c("Feb", "Apr", "May", "Aug", "Oct", "Dec")) +
  theme_pca() +
  theme(axis.title.x = element_blank()) +
  ylab("PC2 Scores")

pdf("output/plots/med_PC2.pdf", width = 3, height = 3)
plot(med_PC2)
dev.off()

temp_PC2 <- ggplot(PCA_results[Class == "Temperate"], aes(x = campaign, y = PC2)) +
  geom_line(aes(group = site, color = groups.x), lwd = 0.3) +
  geom_point(aes(group = site, shape = groups.x, fill = groups.x), size = 2, color = "black") +
  geom_line(data = monthly_mean_variables[groups.x == "TempAlt" | groups.x == "TempNat"],
            aes(x = campaign, y = PC2, group = groups.x, color = groups.x), lwd = 1.3) +
  scale_shape_manual(values = c(23, 22)) +
  scale_color_manual(values = c("#B4DCED", "#6996D1")) +
  scale_fill_manual(values = c("#B4DCED", "#6996D1")) +
  scale_x_discrete(limits = c("Feb", "Apr", "May", "Aug", "Oct", "Dec"),
                   labels = c("Feb", "Apr", "May", "Aug", "Oct", "Dec")) +
  theme_pca() +
  theme(axis.title.x = element_blank()) +
  ylab("PC2 Scores")

pdf("output/plots/temp_PC2.pdf", width = 3, height = 3)
plot(temp_PC2)
dev.off()

med_beta_alpha <- ggplot(PCA_results[Class == "Mediterranean"], aes(x = campaign, y = beta.alpha)) +
  geom_line(aes(group = site, color = groups.x), lwd = 0.3) +
  geom_point(aes(group = site, shape = groups.x, fill = groups.x), size = 2, color = "black") +
  geom_line(data = monthly_mean_variables[groups.x == "MedAlt" | groups.x == "MedNat"],
            aes(x = campaign, y = beta.alpha, group = groups.x, color = groups.x), lwd = 1.3) +
  scale_shape_manual(values = c(25, 24)) +
  scale_color_manual(values = c("#F5CB7D", "#F09E41")) +
  scale_fill_manual(values = c("#F5CB7D", "#F09E41")) +
  scale_x_discrete(limits = c("Feb", "Apr", "May", "Aug", "Oct", "Dec"),
                   labels = c("Feb", "Apr", "May", "Aug", "Oct", "Dec")) +
  theme_pca() +
  theme(axis.title.x = element_blank()) +
  ylab("beta/alpha")

pdf("output/plots/med_beta_alpha.pdf", width = 3, height = 3)
plot(med_beta_alpha)
dev.off()

temp_beta_alpha <- ggplot(PCA_results[Class == "Temperate"], aes(x = campaign, y = beta.alpha)) +
  geom_line(aes(group = site, color = groups.x), lwd = 0.3) +
  geom_point(aes(group = site, shape = groups.x, fill = groups.x), size = 2, color = "black") +
  geom_line(data = monthly_mean_variables[groups.x == "TempAlt" | groups.x == "TempNat"],
            aes(x = campaign, y = beta.alpha, group = groups.x, color = groups.x), lwd = 1.3) +
  scale_shape_manual(values = c(23, 22)) +
  scale_color_manual(values = c("#B4DCED", "#6996D1")) +
  scale_fill_manual(values = c("#B4DCED", "#6996D1")) +
  scale_x_discrete(limits = c("Feb", "Apr", "May", "Aug", "Oct", "Dec"),
                   labels = c("Feb", "Apr", "May", "Aug", "Oct", "Dec")) +
  theme_pca() +
  theme(axis.title.x = element_blank()) +
  ylab("beta/alpha")

pdf("output/plots/temp_beta_alpha.pdf", width = 3, height = 3)
plot(temp_beta_alpha)
dev.off()

### Tests for temporal variation ####

#### Beta.Alpha ####
### April ###
april <- PCA_results[campaign == "Apr"]

shapiro.test((april$beta.alpha))
hist((april$beta.alpha))

bartlett.test((beta.alpha) ~ groups.x, data = april)
oneway.test((beta.alpha) ~ groups.x, var.equal = TRUE, data = april)

### August ###
august <- PCA_results[campaign == "Aug"]

shapiro.test((august$beta.alpha))
hist((august$beta.alpha))

bartlett.test((beta.alpha) ~ groups.x, data = august)
oneway.test((beta.alpha) ~ groups.x, var.equal = TRUE, data = august)

### October ###
october <- PCA_results[campaign == "Oct"]

shapiro.test((october$beta.alpha))
hist((october$beta.alpha))

bartlett.test((beta.alpha) ~ groups.x, data = october)
oneway.test((beta.alpha) ~ groups.x, var.equal = TRUE, data = october)

var.test((beta.alpha) ~ alteration, data = october[Class == "Mediterranean"])
t.test((beta.alpha) ~ alteration, data = october[Class == "Mediterranean"], var.equal = TRUE)

var.test((beta.alpha) ~ alteration, data = october[Class == "Temperate"])
t.test((beta.alpha) ~ alteration, data = october[Class == "Temperate"], var.equal = TRUE)

var.test((beta.alpha) ~ Class, data = october[alteration == "Natural"])
t.test((beta.alpha) ~ Class, data = october[alteration == "Natural"], var.equal = TRUE)

p.adjust(c(0.0009177, 0.2736, 0.4189), method = "bonferroni", n = 3)
m <- pairwise.t.test(log(october$beta.alpha), october$groups.x, p.adjust.method = "bonferroni", pool.sd = FALSE)
multcompView::multcompLetters(rcompanion::fullPTable(m$p.value))

### December ###
december <- PCA_results[campaign == "Dec"]

shapiro.test((december$beta.alpha))
hist((december$beta.alpha))

bartlett.test((beta.alpha) ~ groups.x, data = december)
oneway.test((beta.alpha) ~ groups.x, var.equal = FALSE, data = december)

var.test((beta.alpha) ~ alteration, data = october[Class == "Mediterranean"])
var.test((beta.alpha) ~ alteration, data = october[Class == "Temperate"])
var.test((beta.alpha) ~ Class, data = october[alteration == "Natural"])

### February ###
february <- PCA_results[campaign == "Feb"]

shapiro.test((february$beta.alpha))
hist((february$beta.alpha))

bartlett.test((beta.alpha) ~ groups.x, data = february)
oneway.test((beta.alpha) ~ groups.x, var.equal = TRUE, data = february)

### April ###
may <- PCA_results[campaign == "May"]

shapiro.test((may$beta.alpha))
hist((may$beta.alpha))

bartlett.test((beta.alpha) ~ groups.x, data = may)
oneway.test((beta.alpha) ~ groups.x, var.equal = TRUE, data = may)

#### PC1 ####
### April ###
shapiro.test((april$PC1))
hist((april$PC1))

bartlett.test((PC1) ~ groups.x, data = april)
oneway.test((PC1) ~ groups.x, var.equal = TRUE, data = april)

### August ###
shapiro.test((august$PC1))
hist((august$PC1))

bartlett.test((PC1) ~ groups.x, data = august)
oneway.test((PC1) ~ groups.x, var.equal = TRUE, data = august)

var.test((PC1) ~ alteration, data = october[Class == "Mediterranean"])
t.test((PC1) ~ alteration, data = october[Class == "Mediterranean"], var.equal = TRUE)

var.test((PC1) ~ alteration, data = october[Class == "Temperate"])
t.test((PC1) ~ alteration, data = october[Class == "Temperate"], var.equal = TRUE)

var.test((PC1) ~ Class, data = october[alteration == "Natural"])
t.test((PC1) ~ Class, data = october[alteration == "Natural"], var.equal = TRUE)

p.adjust(c(0.03121,  0.6493, 0.4405), method = "bonferroni", n = 3)
m <- pairwise.t.test((october$PC1), october$groups.x, p.adjust.method = "bonferroni", pool.sd = FALSE)

### Octıber ###
shapiro.test((october$PC1))
hist((october$PC1))

bartlett.test((PC1) ~ groups.x, data = october)
oneway.test((PC1) ~ groups.x, var.equal = TRUE, data = october)

### December ###
shapiro.test((december$PC1))
hist((december$PC1))

bartlett.test((PC1) ~ groups.x, data = december)
oneway.test((PC1) ~ groups.x, var.equal = FALSE, data = december)

### February ###
shapiro.test(log(february$PC1))
hist((february$PC1))

bartlett.test((PC1) ~ groups.x, data = february)
oneway.test((PC1) ~ groups.x, var.equal = TRUE, data = february)

### May ###
shapiro.test((may$PC1))
hist((may$PC1))

bartlett.test((PC1) ~ groups.x, data = may)
oneway.test((PC1) ~ groups.x, var.equal = TRUE, data = may)

#### End PC1 ###

#### PC2 ####
### April ###
shapiro.test((april$PC2))
hist((april$PC2))

bartlett.test((PC2) ~ groups.x, data = april)
oneway.test((PC2) ~ groups.x, var.equal = TRUE, data = april)

### August ###
shapiro.test((august$PC2))
hist((august$PC2))

bartlett.test((PC2) ~ groups.x, data = august)
oneway.test((PC2) ~ groups.x, var.equal = TRUE, data = august)

### Octıber ###
shapiro.test((october$PC2))
hist((october$PC2))

bartlett.test((PC2) ~ groups.x, data = october)
oneway.test((PC2) ~ groups.x, var.equal = TRUE, data = october)

var.test((PC2) ~ alteration, data = october[Class == "Mediterranean"])
t.test((PC2) ~ alteration, data = october[Class == "Mediterranean"], var.equal = FALSE)

var.test((PC2) ~ alteration, data = october[Class == "Temperate"])
t.test((PC2) ~ alteration, data = october[Class == "Temperate"], var.equal = FALSE)

var.test((PC2) ~ Class, data = october[alteration == "Natural"])
t.test((PC2) ~ Class, data = october[alteration == "Natural"], var.equal = TRUE)

p.adjust(c(0.08078,  0.517, 0.1992), method = "bonferroni", n = 3)
m <- pairwise.t.test((october$PC2), october$groups.x, p.adjust.method = "bonferroni", pool.sd = FALSE)


### December ###
shapiro.test((december$PC2))
hist((december$PC2))

bartlett.test((PC2) ~ groups.x, data = december)
oneway.test((PC2) ~ groups.x, var.equal = FALSE, data = december)

### February ###
shapiro.test((february$PC2))
hist((february$PC2))

bartlett.test((PC2) ~ groups.x, data = february)
oneway.test((PC2) ~ groups.x, var.equal = TRUE, data = february)

### May ###
shapiro.test((may$PC2))
hist((may$PC2))

bartlett.test((PC2) ~ groups.x, data = may)
oneway.test((PC2) ~ groups.x, var.equal = TRUE, data = may)
#### End PC2 ###
