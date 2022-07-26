- dashboard: 7_day_active_gaia_ids_for_selected_date_and_product
  title: 7 Day Active Gaia IDs for selected date and product
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: GhGFUMG9vh0xy1XLduMs6l
  elements:
  - title: 7 day active Gaia IDs across various regions
    name: 7 day active Gaia IDs across various regions
    model: workinsights
    explore: customer_7_daily_active_users_normalized
    type: looker_map
    fields: [customer_7_daily_active_users_normalized.country_code, count_of_gaia_id]
    filters:
      customer_7_daily_active_users_normalized.gaia_id: NOT NULL
    sorts: [count_of_gaia_id desc 0]
    limit: 500
    dynamic_fields: [{category: measure, expression: '', label: Count of Gaia ID,
        value_format: "#,###", value_format_name: !!null '', based_on: customer_7_daily_active_users_normalized.gaia_id,
        _kind_hint: measure, measure: count_of_gaia_id, type: count_distinct, _type_hint: number}]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.7
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    series_types: {}
    defaults_version: 1
    listen:
      Date: customer_7_daily_active_users_normalized.date_range_activity
      Product: customer_7_daily_active_users_normalized.product
    row: 8
    col: 5
    width: 10
    height: 11
  - title: Percentage of Gaia IDs by OU
    name: Percentage of Gaia IDs by OU
    model: workinsights
    explore: customer_7_daily_active_users_normalized
    type: looker_pie
    fields: [customer_7_daily_active_users_normalized.ou_id, count_of_gaia_id]
    filters:
      customer_7_daily_active_users_normalized.gaia_id: NOT NULL
    sorts: [count_of_gaia_id desc 0]
    limit: 500
    dynamic_fields: [{category: measure, expression: '', label: Count of Gaia ID,
        value_format: "#,###", value_format_name: !!null '', based_on: customer_7_daily_active_users_normalized.gaia_id,
        _kind_hint: measure, measure: count_of_gaia_id, type: count_distinct, _type_hint: number}]
    value_labels: labels
    label_type: labPer
    series_types: {}
    defaults_version: 1
    listen:
      Date: customer_7_daily_active_users_normalized.date_range_activity
      Product: customer_7_daily_active_users_normalized.product
    row: 0
    col: 10
    width: 10
    height: 8
  - title: 'Gaia IDs active in last 7 days '
    name: 'Gaia IDs active in last 7 days '
    model: workinsights
    explore: customer_7_daily_active_users_normalized
    type: looker_grid
    fields: [customer_7_daily_active_users_normalized.gaia_id]
    filters:
      customer_7_daily_active_users_normalized.gaia_id: NOT NULL
    sorts: [customer_7_daily_active_users_normalized.gaia_id]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    series_value_format:
      customer_7_daily_active_users_normalized.gaia_id:
        name: id
        format_string: '0'
        label: ID
    series_types: {}
    defaults_version: 1
    listen:
      Date: customer_7_daily_active_users_normalized.date_range_activity
      Product: customer_7_daily_active_users_normalized.product
    row: 0
    col: 0
    width: 10
    height: 8
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
      options: []
    model: workinsights
    explore: customer_daily_active_users_drill_down
    listens_to_filters: []
    field: customer_daily_active_users_new.product
  - name: Date
    title: Date
    type: field_filter
    default_value: 2022/07/27
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: workinsights
    explore: customer_daily_active_users_drill_down
    listens_to_filters: []
    field: customer_daily_active_users_new.date_range_activity
