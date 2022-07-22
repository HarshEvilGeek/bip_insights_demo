- dashboard: daily_active_users
  title: Daily Active Users
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: nPlW86HHc2GOv7wxSeomiv
  elements:
  - title: 7 Day Active Users
    name: 7 Day Active Users
    model: workinsights
    explore: customer_daily_active_users_new
    type: looker_column
    fields: [customer_daily_active_users_new.date_range_activity, count_of_gaia_id]
    fill_fields: [customer_daily_active_users_new.date_range_activity]
    filters:
      customer_daily_active_users_new.gaia_id: NOT NULL
    sorts: [customer_daily_active_users_new.date_range_activity desc]
    limit: 500
    dynamic_fields: [{measure: count_of_gaia_id, based_on: customer_daily_active_users_new.gaia_id,
        expression: '', label: Count of Gaia ID, type: count_distinct, _kind_hint: measure,
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: 7 Day active users count, orientation: left, series: [{axisId: count_of_gaia_id,
            id: count_of_gaia_id, name: Count of Gaia ID}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Days
    series_types: {}
    series_colors:
      count_of_gaia_id: "#0872a8"
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    listen:
      Product: customer_daily_active_users_new.product
    row: 0
    col: 0
    width: 20
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
      html: Hello
    model: workinsights
    explore: customer_daily_active_users_new
    listens_to_filters: []
    field: customer_daily_active_users_new.product
