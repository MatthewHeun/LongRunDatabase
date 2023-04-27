tar_target(ruvy_df, {
  iron_steel |> 
    dplyr::group_by(Year, Country, Energy.type, Matrix) |> 
    matsindf::collapse_to_matrices(matnames = "Matrix", 
                                   rownames = "From", 
                                   colnames = "To",
                                   matvals = "Value") |> 
    tidyr::pivot_wider(names_from = "Matrix", values_from = "Value") |> 
    # Set row and column types
    dplyr::mutate(
      R = R |> matsbyname::setrowtype("Industry") |> matsbyname::setcoltype("Product"), 
      U = U |> matsbyname::setrowtype("Product") |> matsbyname::setcoltype("Industry"), 
      V = V |> matsbyname::setrowtype("Industry") |> matsbyname::setcoltype("Product"), 
      Y = Y |> matsbyname::setrowtype("Product") |> matsbyname::setcoltype("Industry")
    )
})
