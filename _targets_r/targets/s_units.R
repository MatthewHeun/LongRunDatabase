tar_target(s_units, {
  iron_steel |> 
    dplyr::mutate(
      # Create a "Product" as expected when creating the S_units matrix.
      "{IEATools::iea_cols$product}" := dplyr::case_when(
        .data[["Matrix"]] %in% c("R", "V") ~ .data[["To"]], 
        .data[["Matrix"]] %in% c("U", "Y") ~ .data[["From"]], 
        TRUE ~ NA_character_
      ), 
      # Create a "Flow" as expected when creating the S_units matrix.
      "{IEATools::iea_cols$flow}" := dplyr::case_when(
        .data[["Matrix"]] %in% c("R", "V") ~ .data[["From"]], 
        .data[["Matrix"]] %in% c("U", "Y") ~ .data[["To"]], 
        TRUE ~ NA_character_
      ), 
      # Eliminate unneeded columns.
      From = NULL, 
      To = NULL, 
      Matrix = NULL
    ) |> 
    # Now make the S_units vectors
    IEATools::extract_S_units_from_tidy(matnames = "Matrix", e_dot = "Value")
})
