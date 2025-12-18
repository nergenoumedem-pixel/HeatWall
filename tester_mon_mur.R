library(HeatWall)
library(ggplot2)
# --- Définir les scénarios de mur ---
# 1. Le mur non isolé (Béton simple, le scénario "problème")
mur_probleme <- material_properties[material_properties$material == "Concrete", ]
# 2. Le mur optimisé (Brique de terre + Polyuréthane, le scénario "solution")
mur_solution_isole <- rbind(
  material_properties[material_properties$material == "Compressed_Earth_Brick", ],
  material_properties[material_properties$material == "Polyurethane_Foam", ]
)
print("Propriétés des matériaux utilisés:")
print(mur_solution_isole)
# --- Paramètres de la simulation (Climat de Douala) ---
temp_ext_douala <- 36 # Une journée très chaude à Douala
temp_int_initial <- 24 # On démarre la clim ou la journée à 24°C
# Simuler sur 48 heures (2 jours)
temps_simulation_heures <- 48
# --- Exécuter les simulations avec votre fonction HeatWallR::simulate_wall_temp ---
resultats_probleme <- simulate_wall_temp(
  materials = mur_probleme,
  initial_temp_in = temp_int_initial,
  external_temp = temp_ext_douala,
  total_time = temps_simulation_heures,
  dt = 0.01,
  dx = 0.01
)
resultats_probleme$Scenario <- "Mur Probleme (Béton Simple)"

resultats_solution <- simulate_wall_temp(
  materials = mur_solution_isole,
  initial_temp_in = temp_int_initial,
  external_temp = temp_ext_douala,
  total_time = temps_simulation_heures,
  dt = 0.01,
  dx = 0.01
)
resultats_solution$Scenario <- "Mur Solution (Brique + PU)"


# --- Visualisation des résultats ---

donnees_finales <- rbind(resultats_probleme, resultats_solution)

ggplot(donnees_finales, aes(x = Time, y = InternalTemp, color = Scenario)) +
  geom_line(linewidth  = 1.5) +
  labs(
    title = "Efficacité d'isolation (Brique de Terre + Polyuréthane) vs Béton",
    subtitle = paste("Temperature Extérieure Constante:", temp_ext_douala, "°C"),
    x = "Temps (Heures)",
    y = "Température Intérieure (°C)",
    color = "Configuration du Mur"
  ) +
  scale_color_manual(values = c("Mur Probleme (Béton Simple)" = "red", "Mur Solution (Brique + PU)" = "blue")) +
  theme_minimal() +
  geom_hline(yintercept = temp_ext_douala, linetype = "dashed", color = "green", linewidth = 0.8) +
  annotate("text", x = 40, y = temp_ext_douala + 0.5, label = "T° Extérieure (36°C)", color = "green")
