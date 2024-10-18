public class Greedy2 extends Greedy{
    @Override
    public int heuristic(WaterBottle[] waterBottles) {
        // return the number of bottles that are not filled with the same color
        int count = 0;
        for (WaterBottle waterBottle : waterBottles) {
            if (!waterBottle.isSameColor) {
                count++;
            }
        }
        return count;
    }
}
