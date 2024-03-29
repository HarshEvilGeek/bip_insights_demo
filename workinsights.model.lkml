# Define the database connection to be used for this model.
connection: "looker-private-demo-1"

# include all the views
include: "/views/**/*.view"
include: "/WorkInsightsAdoption.dashboard"
# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: bip_insights_demo_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: bip_insights_demo_default_datagroup
