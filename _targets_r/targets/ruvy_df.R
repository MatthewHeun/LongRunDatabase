tar_target(ruvy_df, {
  iron_steel |> 
    dplyr::group_by(Year, Country, Energy.type, Matrix) |> 
    matsindf::collapse_to_matrices(matnames = "Matrix", 
                                   rownames = "From", 
                                   colnames = "To",
                                   matvals = "Value",
                                   matrix.class = "matrix") |> 
    tidyr::pivot_wider(names_from = "Matrix", values_from = "Value") |> 
    dplyr::mutate(
      # Set row and column types
      R = R |> matsbyname::setrowtype("Industry") |> matsbyname::setcoltype("Product"), 
      U = U |> matsbyname::setrowtype("Product") |> matsbyname::setcoltype("Industry"), 
      V = V |> matsbyname::setrowtype("Industry") |> matsbyname::setcoltype("Product"), 
      Y = Y |> matsbyname::setrowtype("Product") |> matsbyname::setcoltype("Industry")
    ) |> 
    # Join with the S_units matrices
    dplyr::left_join(s_units)
})
