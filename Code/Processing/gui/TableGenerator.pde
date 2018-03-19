// create table
public Table createTable() {
  table = new Table();

  table.addColumn("id");
  table.addColumn("distance");
  table.addColumn("loadcell_value");
    
  table.addColumn("current_cycle");
  table.addColumn("current_direction");
  table.addColumn("current_time");
  return table;
}

// ADD ROWS
public TableRow addRow(Table table) {
  TableRow newRow = table.addRow();
  return newRow;
}

// SET DATA IN ROWS
// IT CAN USE THE LOCAL VARIABLES IN GUI.PDE
public void setRowData(TableRow newRow) {
  newRow.setInt("id", table.lastRowIndex());
  
  newRow.setDouble("distance", fake_distance);
  newRow.setDouble("loadcell_value", loadcell_value);
 
  //GRAPH the new value here maybe create and use prev variables to store previous value
  
  newRow.setDouble("current_cycle", current_cycle/2.0);
  newRow.setString("current_direction", current_direction);
  newRow.setInt("current_time", millis());
  
}  
