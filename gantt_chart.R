library(tidyr)
library(ggplot2)

# Number of activities
act_nums <- 7

# Ordered unique activities and components 
acts <- c("Task 1","Task 2", "Task 3", "Task 4")
comps <- c("Component 1", "Component 2", "Component 3") 

# Dataframe of activities with the corresponding component and dates
activity_df <- data.frame(
  item = 1:act_nums,
  activity = factor(c("Task 1",rep("Task 2",2), rep("Task 3",2), "Task 4", 
                      "Task 4"), acts[length(acts):1]),
  component = factor(c("Component 1", "Component 1", "Component 2", 
                       "Component 1","Component 2","Component 2", 
                       "Component 3"),comps),
  start_date = as.Date(c("2020-06-01","2020-06-01", "2020-07-16","2020-09-01",
                         "2020-10-01","2020-11-15", "2021-01-17")), 
  end_date = as.Date(c("2020-09-30","2020-07-15" ,"2020-08-31", "2020-09-30",
                       "2020-11-30", "2020-12-15", "2021-01-23"))
)

# Prepare data for plotting
g_activity_df <- activity_df %>% gather(state, date, start_date:end_date,
                                        factor_key = TRUE)

# Default ggplot seetings
# ggplot(g_activity_df, aes(date, activity, gorup=item, color=component))+
#   geom_line(size=10) +
#   labs(x="Month", y=NULL, title="Work Plan For The Next 6 Months")+
#   theme_bw()

# Custom color and theme 
# Component colors
actcols <- c("#548235", "#2E75B6", "#BF9000")

# Plot gantt chart
ggplot(g_activity_df, aes(date, activity, gorup=item, color=component))+
  geom_line(size=14) +
  scale_color_manual(values = actcols, name="Work Component")+
  scale_x_date(breaks=seq.Date(as.Date("2020-06-01"), 
                               as.Date("2021-02-01"), "month"), 
               labels = c(month.abb[6:12],month.abb[1:2]))+
  labs(x=NULL, y=NULL, title="Work Plan For The Next 6 Months") +
  theme_bw(base_size = 14)+
  theme(axis.text.y = element_text(size=11),
        axis.text.x = element_text(angle = 0),
        legend.text = element_text(size=11),
        panel.grid.minor = element_blank())
#legend.title = element_blank()
