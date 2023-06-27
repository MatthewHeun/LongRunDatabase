tar_target(ruvy_df, {
  iron_steel |> 
    dplyr::group_by(Year, Country, Energy.type, Matrix) |> 
    matsindf::collapse_to_matrices(matnames = "Matrix", 
                                   rownames = "From", 
                                   colnames = "To",
                                   matvals = "Value",
                                   matrix_class = "matrix") |> 
    tidyr::pivot_wider(names_from = "Matrix", values_from = "Value") |> 
    dplyr::mutate(
      # Set row and column types
      R = R |> matsbyname::setrowtype("Industry") |> matsbyname::setcoltype("Product"), 
      U = U |> matsbyname::setrowtype("Product") |> matsbyname::setcoltype("Industry"), 
      V = V |> matsbyname::setrowtype("Industry") |> matsbyname::setcoltype("Product"), 
      Y = Y |> matsbyname::setrowtype("Product") |> matsbyname::setcoltype("Industry"), 
      # Create other expected matrices
      # The U_feed matrix is same as U
      U_feed = U, 
      # Create a U_EIOU matrix full of zeros but with same rows and columns as U
      U_EIOU = matsbyname::hadamardproduct_byname(U, 0),
      # Create an r_EIOU matrix, again full of zeroes
      r_EIOU = U_EIOU
    ) |> 
    # Join with the S_units matrices
    dplyr::left_join(s_units, by = c("Year", "Country", "Energy.type"))
})
