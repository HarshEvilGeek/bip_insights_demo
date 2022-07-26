- dashboard: daily_active_users
  title: Daily Active Users
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Summary\n\nLearn usage trends broken down by apps.\n\n7-day active\
    \ users : Used the app at least once in the past 7 days.\n\nHow it's calculated\n\
    % X days active users : Number of active users in X days divided by the total\
    \ number of users with access to Google "
  preferred_slug: nPlW86HHc2GOv7wxSeomiv
  elements:
  - title: 7 Day Active Users
    name: 7 Day Active Users
    model: workinsights
    explore: customer_7_daily_active_users_normalized
    type: looker_column
    fields: [customer_7_daily_active_users_normalized.date_range_activity, customer_7_daily_active_users_normalized.total_count_gaia_id,
      count_of_gaia_id]
    filters:
      customer_7_daily_active_users_normalized.gaia_id: NOT NULL
    sorts: [customer_7_daily_active_users_normalized.date_range_activity desc]
    limit: 500
    dynamic_fields: [{measure: count_of_gaia_id, based_on: customer_7_daily_active_users_normalized.gaia_id,
        expression: '', label: Count of Gaia ID, type: count_distinct, _kind_hint: measure,
        _type_hint: number}, {category: table_calculation, expression: '100*${count_of_gaia_id}/${customer_7_daily_active_users_normalized.total_count_gaia_id}',
        label: Percentage of 7 day active users, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: percentage_of_7_day_active_users,
        _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: 7 Day active users, orientation: left, series: [{axisId: percentage_of_7_day_active_users,
            id: percentage_of_7_day_active_users, name: Percentage of 7 day active
              users}], showLabels: true, showValues: true, maxValue: 100, minValue: 0,
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 52, type: linear}]
    label_value_format: "#.#\\%"
    series_types: {}
    series_colors:
      new_calculation: "#0872a8"
      percentage_of_active_users: "#0872a8"
      percentage_of_7_day_active_users: "#0872a8"
    defaults_version: 1
    hidden_fields: [customer_7_daily_active_users_normalized.total_count_gaia_id,
      count_of_gaia_id]
    listen:
      Product: customer_7_daily_active_users_normalized.product
    row: 0
    col: 0
    width: 21
    height: 12
  filters:
  - name: Product
    title: Product
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_toggles
      display: inline
    model: workinsights
    explore: customer_7_daily_active_users_normalized
    listens_to_filters: []
    field: customer_7_daily_active_users_normalized.product
