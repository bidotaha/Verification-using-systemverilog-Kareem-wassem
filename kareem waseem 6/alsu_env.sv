
package alsu_env_pkg;
import alsu_agent_pkg::*;
import alsu_sco_pkg::*;
import alsu_coverage_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class alsu_env extends uvm_env;
  `uvm_component_utils (alsu_env)  

alsu_agent agt;
alsu_sco sb;
alsu_coverage cov;
   
  function new (string name = "alsu_env" , uvm_component parent = null);
    super.new (name,parent);
  endfunction 

  function void build_phase (uvm_phase phase);
    super.build_phase (phase);
    agt = alsu_agent::type_id::create ("agt",this);
    sb = alsu_sco::type_id::create ("sb",this);
    cov = alsu_coverage::type_id::create ("cov",this);
  endfunction

  function void connect_phase (uvm_phase phase);
   agt.agt_ap.connect(sb.sb_export);
   agt.agt_ap.connect(cov.cov_export);
  endfunction

endclass
endpackage