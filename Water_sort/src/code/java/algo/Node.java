package algo;

import java.util.ArrayList;
import java.util.function.Function;

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

    public ArrayList<Node> get_children(Function<Integer, Integer> evalFunc){
        ArrayList<Node> res = new ArrayList<>();
        for(int i=0;i<this.water_bottles.length;i++){
            WaterBottle wb1 = this.water_bottles[i];
//            System.out.println("get children");
            for(int j=i+1;j<this.water_bottles.length;j++){
//                System.out.println("get children inner");
                WaterBottle wb2 = this.water_bottles[j];
//                System.out.println("Node one");
                Node one = this.get_child(wb1, wb2, i, j, evalFunc);
//                System.out.println("Node two");
                Node two = this.get_child(wb2, wb1, j, i, evalFunc);
                if (one != null) res.add(one);
                if (two != null) res.add(two);
            }
        }
//        System.out.println(res);
        return res;
    }

    public Node get_child(WaterBottle wb1, WaterBottle wb2, int i, int j, Function<Integer, Integer> evalFunc){
        int layersPoured = 0;
        WaterBottle wb1_temp = wb1.clone();
        WaterBottle wb2_temp = wb2.clone();
        String operator = "pour_"+wb1.id+"_"+wb2.id;
//        System.out.println(operator);
        while (wb1_temp.isInsertable(wb2_temp)) {
//            System.out.println("isInsertable");
//            System.out.println(wb1_temp+"--"+wb2_temp);
            WaterBottle[] waterBottles = this.pour(wb1_temp, wb2_temp);
            wb1_temp = waterBottles[0];
            wb2_temp = waterBottles[1];
            layersPoured++;
        }
        if(layersPoured>0){
            WaterBottle[] newWaterBottles = this.water_bottles.clone();
            newWaterBottles[i] = wb1_temp;
            newWaterBottles[j] = wb2_temp;
            int addedCost = evalFunc.apply(layersPoured);
            return new Node(this, this.cost+addedCost, this.depth+1, operator, newWaterBottles);
        }
        return null;
    }


    public WaterBottle[] pour(WaterBottle wb1, WaterBottle wb2){
        WaterBottle[] wbs = new WaterBottle[2];
        WaterBottle wb1_copy = wb1.clone();
        String removed_color = wb1_copy.removeColor();
        WaterBottle wb2_copy = wb2.clone();
        boolean isInserted = wb2_copy.insertColor(removed_color);
        wbs[0] = wb1_copy;
        wbs[1] = wb2_copy;
//        System.out.println("In pour: "+wb1_copy+"---"+wb2_copy+"////"+"removed_color: "+removed_color+"///isInserted:"+isInserted);
        return wbs;
    }
}
