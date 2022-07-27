explore: user_id_map {}
# The name of this view in Looker is "User ID Map"
view: user_id_map {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `bip-insights.looker_poc.UserIdMap`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Country Code" in Explore.

  dimension: country_code {
    map_layer_name: countries
    sql: ${TABLE}.country_code ;;
  }

  dimension: gaia_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.gaia_id ;;
  }

  dimension: ou_id {
    type: number
    sql: ${TABLE}.ou_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
