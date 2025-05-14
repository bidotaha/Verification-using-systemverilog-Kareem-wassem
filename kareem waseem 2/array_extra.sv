module array_2 ();
    
    bit [12] my_array [4];
    int j = 0;

    initial begin
        my_array [0] = 12'h012;
        my_array [1] = 12'h345;
        my_array [2] = 12'h678;
        my_array [3] = 12'h9ab;
        $display(" my_arrar = %p", my_array);

        for (int k= 0; k<4 ; k++) begin
         for (int i=4 ; i<6 ; i++) begin
            $display(" bits [4:5] = %b", my_array [j][i]);
        end
        j++;
        end

    end
endmodule