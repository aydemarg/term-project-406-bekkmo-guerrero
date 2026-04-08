#Packages


#Load Data
load("data_clean/olympics_viz_clean.RData")

#Check raw data plots

#Medals Distribution
p1 = ggplot(olympics_final, aes(x = total)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Raw Distribution of Olympic Medals",
    x = "Total Medals",
    y = "Number of Country-Year Observations"
  ) +
  theme_minimal()
ggsave("output/figures/fig1_raw_medal_distribution.png", plot = p1, width = 8, height = 5, dpi = 300)

#GDP per capital
p2 = ggplot(olympics_final, aes(x = gdp_per_capita_ppp)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Raw Distribution of GDP per Capita",
    x = "GDP per Capita (PPP)",
    y = "Number of Country-Year Observations"
  ) +
  theme_minimal()

ggsave("output/figures/fig2_raw_dist_GDPpercap.png", plot = p2, width = 8, height = 5, dpi = 300)

#population
p3 = ggplot(olympics_final, aes(x = population_total)) +
  geom_histogram(bins = 30) +
  labs(
    title = "Raw Distribution of Population",
    x = "Population",
    y = "Number of Country-Year Observations"
  ) +
  theme_minimal()

ggsave("output/figures/fig3_raw_dist_GDPpercap.png", plot = p3, width = 8, height = 5, dpi = 300)


#--------------------------
#Data log Transformation
#--------------------------

#Plots after transformation
#Medals Distribution 
p4 = ggplot(olympics_viz_clean, aes(x = medals_per_million)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  coord_cartesian(xlim = c(0, 10)) +
  labs(
    title = "Distribution of Medals per Million People (Zoomed In)",
    x = "Medals per Million",
    y = "Number of Country-Year Observations"
  ) +
  theme_minimal()

ggsave("output/figures/fig4_log_dist.png", plot = p4, width = 8, height = 5, dpi = 300)

#GDP per capital
p5 = ggplot(olympics_viz_clean, aes(x = log_gdp)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(
    title = "Log-Transformed GDP per Capita Distribution",
    x = "Log GDP per Capita",
    y = "Number of Country-Year Observations"
  ) +
  theme_minimal()

ggsave("output/figures/fig5_log_dist_GDPpercap.png", plot = p5, width = 8, height = 5, dpi = 300)

#Population
p6 = ggplot(olympics_viz_clean, aes(x = log_population)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(
    title = "Log-Transformed Population Distribution",
    x = "Log Population",
    y = "Number of Country-Year Observations"
  ) +
  theme_minimal()

ggsave("output/figures/fig6_log_dist_pop.png", plot = p6, width = 8, height = 5, dpi = 300)

#Understand relationships between variables

#relationship between GDP and Medals
p7 = ggplot(olympics_viz_clean, aes(x = log_gdp, y = medals_per_million)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship Between GDP per Capita and Olympic Success",
    x = "Log GDP per Capita",
    y = "Medals per Million"
  ) +
  theme_minimal()

ggsave("output/figures/fig7_GDP_medals.png", plot = p7, width = 8, height = 5, dpi = 300)

#relationship 
p8 = ggplot(olympics_viz_clean, aes(x = log_population, y = medals_per_million)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship Between Population and Olympic Success",
    x = "Log Population",
    y = "Medals per Million"
  ) +
  theme_minimal()

ggsave("output/figures/fig8_pop_oly_success.png", plot = p8, width = 8, height = 5, dpi = 300)

# GDP vs medals per million (binned median trend)
p9 = ggplot(olympics_viz_clean, aes(x = log_gdp, y = medals_per_million)) +
  geom_point(alpha = 0.12) +
  geom_smooth(se = FALSE, linewidth = 1.2, color = "steelblue")+
  coord_cartesian(ylim = c(0, 5)) +
  labs(
    title = "Relationship Between GDP per Capita and Medals per Million",
    x = "Log GDP per Capita",
    y = "Medals per Million"
  ) +
  theme_minimal()

ggsave("output/figures/fig9_GPD_medals_per_millp.png", plot = p9, width = 8, height = 5, dpi = 300)

#Total medals over time for a topmajor countries
 top_countries_total <- olympics_final %>%
  group_by(country) %>%
  summarise(total_medals_all_years = sum(total, na.rm = TRUE)) %>%
  slice_max(total_medals_all_years, n = 10)

 p10 = ggplot(top_countries_total,
       aes(x = reorder(country, total_medals_all_years),
           y = total_medals_all_years)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Top 10 Countries by Total Olympic Medals",
    x = NULL,
    y = "Total Medals"
  ) +
  theme_minimal()

ggsave("output/figures/fig10_top10_total_medals.png", plot = p10, width = 8, height = 5, dpi = 300)
