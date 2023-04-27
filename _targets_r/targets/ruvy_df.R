tar_target(ruvy_df, {
  iron_steel |> 
    dplyr::group_by(Year, Country, Matrix) |> 
    matsindf::collapse_to_matrices(matnames = "Matrix", 
                                   rownames = "From", 
                                   colnames = "To",
                                   matvals = "Value") |> 
    tidyr::pivot_wider(names_from = "Matrix", values_from = "Value")
})
