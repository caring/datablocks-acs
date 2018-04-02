include: "rs.*.view.lkml"
include: "zip_codes.view.lkml"

explore: fast_facts {
  from: rs_logrecno_bg_map

  join: block_group_facts {
    from: rs_block_group_facts
    view_label: "Fast Facts"
    sql_on: ${fast_facts.block_group} = ${block_group_facts.logrecno_bg_map_block_group};;
    relationship: one_to_one
  }

  join: tract_zcta_map {
    from: rs_tract_zcta_map
    sql_on: ${fast_facts.geoid11} = ${tract_zcta_map.geoid11};;
    relationship: many_to_one
  }

  join: zcta_distances {
    from: rs_zcta_distances
    sql_on: ${tract_zcta_map.ZCTA5} = ${zcta_distances.zip2} ;;
    relationship: one_to_one
    required_joins: [tract_zcta_map]
  }

  join: city_names {
    from: zip_codes
    sql_on: ${city_names.code} = ${tract_zcta_map.ZCTA5} ;;
    relationship: many_to_one
  }
}
