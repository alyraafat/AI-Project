package algo;

import java.util.ArrayList;

public class Node {
    Node parent;
    int cost;
    int depth;
    String operator;
    WaterBottle[] water_bottles;
    String path;


    public Node(Node parent, int cost, int depth, String operator, WaterBottle[] water_bottles){
        this.parent = parent;
        this.cost = cost;
        this.depth = depth;
        this.operator = operator;
        this.water_bottles = water_bottles;
        this.path = parent == null ? "" : (parent.path.isEmpty() ? this.operator: parent.path + "," + this.operator);
    }

    public ArrayList<Node> get_children(){
        ArrayList<Node> res = new ArrayList<>();
        for(int i=0;i<this.water_bottles.length;i++){
            WaterBottle wb1 = this.water_bottles[i];
            System.out.println("get children");
            for(int j=i+1;j<this.water_bottles.length;j++){
                WaterBottle wb2 = this.water_bottles[j];
                Node one = this.get_child(wb1, wb2, i, j);
                Node two = this.get_child(wb2, wb1, j, i);
                if (one != null) res.add(one);
                if (two != null) res.add(two);
            }
        }
        return res;
    }

    public Node get_child(WaterBottle wb1, WaterBottle wb2, int i, int j){
        int new_cost = 0;
        WaterBottle wb1_temp = wb1.clone();
        WaterBottle wb2_temp = wb2.clone();
        String operator = "pour_"+wb1.id+"_"+wb2.id;
        while (wb1_temp.isInsertable(wb2_temp)) {
            WaterBottle[] waterBottles = this.pour(wb1, wb2);
            wb1_temp = waterBottles[0];
            wb2_temp = waterBottles[1];
            new_cost++;
        }
        if(new_cost>0){
            WaterBottle[] newWaterBottles = this.water_bottles.clone();
            newWaterBottles[i] = wb1_temp;
            newWaterBottles[j] = wb2_temp;

            return new Node(this, this.cost+new_cost, this.depth+1, operator, newWaterBottles);
        }
        return null;
    }


    public WaterBottle[] pour(WaterBottle wb1, WaterBottle wb2){
        WaterBottle[] wbs = new WaterBottle[2];
        WaterBottle wb1_copy = wb1.clone();
        String removed_color = wb1_copy.removeColor();
        WaterBottle wb2_copy = wb2.clone();
        boolean is_inserted = wb2_copy.insertColor(removed_color);
        wbs[0] = wb1_copy;
        wbs[1] = wb2_copy;
        return wbs;
    }
}
