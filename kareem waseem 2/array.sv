module array ();
    int dyn_arr1 [] ;
    int dyn_arr2 [] = '{9,1,8,3,4,4} ;
    int size_arr;

    initial begin
        dyn_arr1 = new [6];
        foreach (dyn_arr1 [i])
                dyn_arr1[i] = i;
     
        size_arr = $size(dyn_arr1);
        $display("dyn_arr1 = %p %d , dyn_arr2 = %p", dyn_arr1,size_arr, dyn_arr2);       

        dyn_arr1.delete();

        dyn_arr2.reverse();
        $display("dyn_arr2 = %p", dyn_arr2);

        dyn_arr2.sort();
        $display("dyn_arr2 = %p", dyn_arr2);

        dyn_arr2.rsort();
        $display("dyn_arr2 = %p", dyn_arr2);

        dyn_arr2.shuffle();
        $display("dyn_arr2 = %p", dyn_arr2);        

    end
    

endmodule