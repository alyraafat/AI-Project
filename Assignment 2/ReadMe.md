<!--StartFragment-->

**Artificial Intelligence Project 2 Report**

- 52-3899 Karim Mohamed Gamaleldin Yehia Gamaleldin T-19

- 52-1008 Aly Raafat AbdelFattah T-19

- 52-1805 Bassel Mohamed Farouk T-19

- 52-7485 Youssef Ahmed Magdi T-16

November 2024

**Introduction:**

This project involves implementing a logic-based agent to solve a simplified version of the Watersort problem using situation calculus in Prolog. The primary goal is to develop an agent capable of reasoning logically to achieve a desired goal state. The agent's task is to ensure that each bottle in the system contains a single color, with the bottles completely filled.

The problem is modeled with several simplifying assumptions, including a limited number of bottles (three), colors (two), and layers per bottle (two). The only action available to the agent is **pour(i, j)**, which moves the top layer of liquid from bottle i to bottle j.

The agent uses a knowledge base to represent the initial state of the system and applies logical reasoning to generate a sequence of actions that lead to the goal state. To manage the limitations of Prolog's depth-first search, an iterative deepening search (IDS) strategy is employed to ensure completeness and avoid infinite loops during backtracking.

This report outlines the fluents used to represent the system state, the successor-state axioms that define state transitions, the implementation of iterative deepening search, and test cases demonstrating the functionality and correctness of the solution.

**Fluents:**

To represent the dynamic state of the Watersort problem, two fluents were used:

1. **top_layer(Bottle, Color, Situation)**

2. **bottom_layer(Bottle, Color, Situation)**

These fluents encapsulate the state of the liquid layers in the bottles at any given situation. The **top_layer** fluent indicates the color of the liquid present in the top layer of a specific bottle in a particular situation, while the **bottom_layer** fluent serves a similar purpose for the bottom layer. Both fluents play a critical role in defining the initial state, representing transitions caused by actions, and determining if the goal state has been reached.

To compose the successor state axioms for each of our fluents, the effect and frame axioms are defined as follows

**_Top_layer Fluent:_**

**\_**_![{"aid":null,"backgroundColorModified":false,"font":{"size":23,"family":"Arial","color":"#000000"},"code":"\\begin{lalign\*}\n&{\\forall_{a,b,c,s}\\,\\text{top\\_layer(b,}\\;\\text{c,}\\;\\text{result(a,}\\;\\text{s))}\\;\\iff\\,}\\\\\n&{\\exists_{b2}\\,a\\,=\\,\\text{pour(b2,}\\;\\text{b)}\\;\\land\\,b\\,\\neq\\,b2\\,\\land\\,c\\,\\neq\\,e\\;\\land\\,\\,\\text{[}\\text{top\\_layer(b2,}\\;\\text{c,}\\;\\text{s}\\text{)}\\;\\lor\\,\\left(\\text{bottom\\_layer(b2,}\\;\\text{c,}\\;\\text{s}\\text{)}\\;\\land\\,\\text{top\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\,\\right)\\text{]}\\;\\land \\text{top\\_layer(b,}\\;\\text{e,}\\;\\text{s}\\text{)}\\,\\land\\,\\text{bottom\\\_layer(b,}\\;\\text{c,}\\;\\text{s}\\text{)}}\\\\\n&{\\lor\\,\\exists_{b2,\\,c2}\\,a\\,=\\,\\text{pour(b,}\\;\\text{b2)}\\;\\land\\,b\\,\\neq b2\\,\\land c\\,=e\\,\\land\\,\\text{top\\_layer(b,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\,\\land\\,\\text{top\\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\;\\land\\,\\,\\left[\\text{bottom\\_layer(b2,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\lor\\,\\text{bottom\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\right]}\\\\\n&{\\lor\\,\\exists_{b2,\\,b3\\,}a\\,=\\,\\text{pour(b2,}\\;\\text{b3)}\\,\\land \\,b\\,\\neq b2\\,\\land b\\,\\neq b3}\\\\\n&{\\lor\\,\\exists*{b2,\\,c2}\\,a\\,=\\,\\text{pour(b,}\\;\\text{b2)}\\,\\land \\,b\\,\\neq b2\\,\\land c\\,=\\,e\\,\\land\\,\\text{top\\\_layer(b,}\\;\\text{e,}\\;\\text{s}\\text{)}\\;\\land\\,\\text{bottom\\\_layer(b,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\land c2\\,\\neq e\\,\\land\\text{top\\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\;\\,\\land\\,\\left[\\text{bottom\\_layer(b2,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\lor\\,\\text{bottom\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\right]}\\\\\n&{\\lor\\,\\exists*{b2,\\,c2}\\,a\\,=\\,\\text{pour(b2,}\\;\\text{b)}\\,\\land \\,b\\,\\neq b2\\,\\land c\\,=\\,e\\,\\,\\land\\,\\text{top\\_layer(b,}\\;\\text{e,}\\;\\text{s}\\text{)}\\,\\land\\text{bottom\\\_layer(b,}\\;\\text{e,}\\;\\text{s}\\text{)}\\;\\land\\,\\left[\\text{top\\_layer(b2,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\lor\\,\\left(\\text{bottom\\_layer(b2,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\land\\,\\text{top\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\right)\\right]\\,\\land c2\\,\\neq e\\,}\t\n\\end{lalign*}","type":"lalign*","id":"1-0","backgroundColor":"#ffffff","ts":1732210408838,"cs":"v5iCEC16SY/3zeTOhQjYuQ==","size":{"width":698,"height":138}}](https://lh7-rt.googleusercontent.com/docsz/AD_4nXel4XoXfnHWeWUB4xVea3ltTMmYP5Gx5hhmTI845tUOIOqznCcTyKCpLt9fX0bWABIRi1_qLRG_VGVYWkaywndWwb0dVwNrfmOYN6FOX0JADiamIF9pfQHiBBrhXsSC00qdcFvDaQ?key=BTAzTMApYNbLRfQzEQn5zw)_**\_**

Base Cases for **top_laye**r Fluent:

- `top_layer(1, T, s0, _)`: For **bottle 1**, the top layer's color (`T`) is taken from the first element in `bottle1(T, _)`.

- `top_layer(2, T, s0, _)`: For **bottle 2**, the top layer's color (`T`) is taken from the first element in `bottle2(T, _)`.

- `top_layer(3, T, s0, _)`: For **bottle 3**, the top layer's color (`T`) is taken from the first element in `bottle3(T, _)`.

Effect Axioms for **top_laye**r Fluent:

The **top_layer** fluent describes the color present in the top layer of a bottle in a given situation. Its behavior is governed by the following two effect axioms, which detail how the **top_layer** of bottles changes as a result of the **pour(Source, Target)** action:

1\. Adding a New Top Color to the Target Bottle

If a target bottle has no top layer and is poured into, the new color added to its top will be the color being poured from the source bottle. This happens under the following conditions:

- The source bottle has either:

  - A top layer with the color **C**, or

  - An empty top layer and a bottom layer with the color **C**.

- The target bottle must:

  - Have an empty top layer, and

  - Have a bottom layer with the same color **C** as the source.

- The source and target bottles are not the same.

2\. Clearing the Top Layer of the Source Bottle

When a source bottle pours its top layer into a target bottle, the top layer of the source becomes empty. This occurs under the following conditions:

- The source bottle must have a top layer of color **C**.

- The target bottle must:

  - Have an empty top layer, and

  - Either have a bottom layer of color **C** or an empty bottom layer.

- The source and target bottles are not the same.

Frame Axioms for **top_layer** Fluent:

The frame axiom for **top_layer** ensures that the fluent's value remains unchanged in situations where an action does not affect the queried bottle. This prevents unintended modifications to unrelated states and accurately models the persistence of the world. The following cases describe the conditions under which the **top_layer** of a bottle remains the same:

1\. Pouring Between Two Unrelated Bottles

If the action involves pouring between two different bottles **(Source and Target)** that are not the bottle in question, the **top_layer** of the queried bottle remains unchanged.

2\. Pouring from the Bottom Layer of the Source Bottle

If a source bottle pours from its bottom layer, its top layer remains empty. This occurs under the following conditions:

- The top_layer of the source is empty.

- The bottom_layer of the source has a color **C** (i.e., it is not empty).

- The top_layer of the target is empty.

- The bottom_layer of the target is either empty or matches the color **C** of the source.

- The source and target bottles are not the same.

3\. Pouring into an Empty Target Bottle

When a source bottle pours into an empty target bottle, the \`top_layer\` of the target remains empty if:

- The bottom_layer of the target is empty.

- The top_layer of the target is empty.

- The source bottle has either:

  - A top_layer of color **C**, or

  - An empty top_layer and a bottom_layer of color **C**.

- The source and target bottles are not the same..

4\. Doing Invalid Pours

Invalid pours are defined as actions that do not follow the rules for pouring liquid from one bottle to another. The cases considered invalid are as follows:

1. **The target bottle is not empty**:

   - Both the top and bottom layers of the target bottle are already filled with colors, making it impossible to pour into.

2. **Pouring a color onto a different color**:

   - The target bottle has an empty top layer but its bottom layer contains a different color,

   - and the source bottle has some color at the top layer or has an empty top layer but some color at the bottom layer,

   - and the color being poured from the source bottle does not match the bottom layer's color in the target bottle.

3. **The source bottle is empty**:

   - Both the top and bottom layers of the source bottle are empty, meaning there is nothing to pour.

4. **Pouring into the same bottle**:

   - The source and target bottles are the same, which is an invalid action since no actual pouring occurs.

We defined a predicate called `is_invalid_pour`, which incorporates the rules for invalid pouring outlined earlier. Subsequently, we created two `top_layer` predicates that utilize the `is_invalid_pour` predicate, with the bottle functioning as the source in one case and as the target in the other. Additionally, we addressed the scenario where a bottle is poured into itself while referencing another bottle in the `top_layer` predicate.

These frame axioms ensure that the top_layer of a bottle remains consistent in scenarios where it is not directly affected by the pour action, thus maintaining logical integrity in the system

---

**_Bottom_layer Fluent:_**

**\_**_![{"aid":null,"backgroundColorModified":false,"font":{"size":11.5,"family":"Arial","color":"#000000"},"code":"\\begin{lalign\*}\n&{\\forall_{a,b,c,s}\\,\\text{top\\_layer(b,}\\;\\text{c,}\\;\\text{result(a,}\\;\\text{s))}\\;\\iff\\,}\\\\\n&{\\exists_{b2}\\,a\\,=\\,\\text{pour(b2,}\\;\\text{b)}\\;\\land\\,b\\,\\neq\\,b2\\,\\land\\,c\\,\\neq\\,e\\;\\land\\,\\,\\text{[}\\text{top\\_layer(b2,}\\;\\text{c,}\\;\\text{s}\\text{)}\\;\\lor\\,\\left(\\text{bottom\\_layer(b2,}\\;\\text{c,}\\;\\text{s}\\text{)}\\;\\land\\,\\text{top\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\,\\right)\\text{]}\\;\\land \\text{top\\_layer(b,}\\;\\text{e,}\\;\\text{s}\\text{)}\\,\\land\\,\\text{bottom\\\_layer(b,}\\;\\text{c,}\\;\\text{s}\\text{)}}\\\\\n&{\\lor\\,\\exists_{b2,\\,c2}\\,a\\,=\\,\\text{pour(b,}\\;\\text{b2)}\\;\\land\\,b\\,\\neq b2\\,\\land c\\,=e\\,\\land\\,\\text{top\\_layer(b,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\,\\land\\,\\text{top\\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\;\\land\\,\\,\\left[\\text{bottom\\_layer(b2,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\lor\\,\\text{bottom\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\right]}\\\\\n&{\\lor\\,\\exists_{b2,\\,b3\\,}a\\,=\\,\\text{pour(b2,}\\;\\text{b3)}\\,\\land \\,b\\,\\neq b2\\,\\land b\\,\\neq b3}\\\\\n&{\\lor\\,\\exists*{b2,\\,c2}\\,a\\,=\\,\\text{pour(b,}\\;\\text{b2)}\\,\\land \\,b\\,\\neq b2\\,\\land c\\,=\\,e\\,\\land\\,\\text{top\\\_layer(b,}\\;\\text{e,}\\;\\text{s}\\text{)}\\;\\land\\,\\text{bottom\\\_layer(b,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\land c2\\,\\neq e\\,\\land\\text{top\\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\;\\,\\land\\,\\left[\\text{bottom\\_layer(b2,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\lor\\,\\text{bottom\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\right]}\\\\\n&{\\lor\\,\\exists*{b2,\\,c2}\\,a\\,=\\,\\text{pour(b2,}\\;\\text{b)}\\,\\land \\,b\\,\\neq b2\\,\\land c\\,=\\,e\\,\\,\\land\\,\\text{top\\_layer(b,}\\;\\text{e,}\\;\\text{s}\\text{)}\\,\\land\\text{bottom\\\_layer(b,}\\;\\text{e,}\\;\\text{s}\\text{)}\\;\\land\\,\\left[\\text{top\\_layer(b2,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\lor\\,\\left(\\text{bottom\\_layer(b2,}\\;\\text{c2,}\\;\\text{s}\\text{)}\\;\\land\\,\\text{top\\_layer(b2,}\\;\\text{e,}\\;\\text{s}\\text{)}\\right)\\right]\\,\\land c2\\,\\neq e\\,}\t\n\\end{lalign*}","type":"lalign*","id":"1-1","backgroundColor":"#ffffff","ts":1732210539757,"cs":"jRpv4XaGRSTfJ9a91ymZmg==","size":{"width":697,"height":138}}](https://lh7-rt.googleusercontent.com/docsz/AD_4nXel4XoXfnHWeWUB4xVea3ltTMmYP5Gx5hhmTI845tUOIOqznCcTyKCpLt9fX0bWABIRi1_qLRG_VGVYWkaywndWwb0dVwNrfmOYN6FOX0JADiamIF9pfQHiBBrhXsSC00qdcFvDaQ?key=BTAzTMApYNbLRfQzEQn5zw)_**\_**

Base Cases for **bottom_laye**r Fluent:

- `bottom_layer(1, B, s0, _)`: For **bottle 1**, the bottom layer's color (`B`) is taken from the second element in `bottle1(_, B)`.

- `bottom_layer(2, B, s0, _)`: For **bottle 2**, the bottom layer's color (`B`) is taken from the second element in `bottle2(_, B)`.

- `bottom_layer(3, B, s0, _)`: For **bottle 3**, the bottom layer's color (`B`) is taken from the second element in `bottle3(_, B)`.

Effect Axioms for **bottom_layer** Fluent

The **bottom_layer** fluent tracks the color of the liquid present in the bottom layer of a bottle at any given situation. Its behavior is defined by the following two effect axioms:

1\. Adding a New Bottom Layer to the Target Bottle

When a source bottle pours into an empty target bottle, the bottom layer of the target becomes the color of the liquid poured. This occurs under the following conditions:

- The top_layer and bottom_layer of the target are both empty.

- The source bottle has either:

  - A top_layer of color **C**, or

  - An empty top_layer and a bottom_layer of color **C**.

  - The source and target bottles are not the same.

2\. Emptying the Bottom Layer of the Source Bottle

If a source bottle pours its bottom layer into another bottle, its bottom layer becomes empty. This occurs under the following conditions:

- The top_layer of the source is empty.

- The bottom_layer of the source contains color **C** (i.e., it is not empty).

- The top_layer of the target is empty.

- The bottom_layer of the target is either empty or already contains color **C**.

- The source and target bottles are not the same.

Frame Axioms for **bottom_layer**

The frame axioms for the **bottom_layer** fluent ensure that its state remains unchanged when a pour action does not directly affect the queried bottle. These axioms handle cases where the **bottom_layer** persists through unrelated actions or specific scenarios where pouring affects only the top layer.

1\. Unrelated Pour Action

If a pour action occurs between two bottles (**Source** and **Target**) that are not the queried bottle, the **bottom_layer** of the queried bottle remains unchanged.

2\. Source Bottle Retains Bottom Layer

When a source bottle is full (has both a top_layer and a bottom_layer), and it pours only its top layer into a target bottle, its bottom_layer remains unchanged. This occurs under the following conditions:

- The top_layer of the source is not empty and has a color **C**.

- The top_layer of the target is empty.

- The bottom_layer of the target is either empty or already has the color **C**.

- The source and target bottles are not the same.

3\. Target Bottle Retains Bottom Layer

When a source bottle pours into a target bottle, the bottom_layer of the target remains unchanged if it already has a color **C**. This occurs under the following conditions:

- The source bottle has either:

  - A top_layer of color **C**, or

  - An empty top_layer and a bottom_layer of color **C**.

- The top_layer of the target is empty.

- The bottom_layer of the target already has the color **C**.

- The source and target bottles are not the same.

4\. Doing Invalid Pours

We created two `bottom_layer` predicates that utilize the `is_invalid_pour` predicate which we mentioned before, with the bottle functioning as the source in one case and as the target in the other. Additionally, we addressed the scenario where a bottle is poured into itself while referencing another bottle in the `bottom_layer` predicate.

These frame axioms ensure that the `bottom_layer` of a bottle remains consistent in scenarios where it is not directly affected by the pour action, thus maintaining logical integrity in the system

---

**Test Cases:**

1. **Test Case 1:**

- KB is as follows:

  - bottle1(b,r)

  - bottle2(b,r)

  - bottle3(e,e)

- Solution: goal(result(pour(1,2),result(pour(2,3),result(pour(1,3),s0))))

- Inferences: 53,685

- CPU Time: 0.003 seconds

- Wall Time: 0.003 seconds

2. **Test Case 2:**

- KB is as follows:

  - bottle1(r,b).

  - bottle2(b,r).

  - bottle3(e,e).

* Solution:

goal(result(pour(2,3),result(pour(2,1),result(pour(1,3),s0))))

- Inferences: 88,674

- CPU Time: 0.007 seconds

- Wall Time: 0.007 seconds

3. **Test Case 3:**

- KB is as follows:

  - bottle1(r,b).

  - bottle2(b,r).

  - bottle3(e,e).

- Solution:

goal(result(pour(3,2),result(pour(2,1),result(pour(1,3),s0))))

- Inferences: 1,159

- CPU Time: 0.001 seconds

- Wall Time: 0.001 seconds

4. **Test Case 4:**

- KB is as follows:

  - bottle1(g,g).

  - bottle2(e,v).

  - bottle3(e,v).

- Solution:

goal(result(pour(2,3),s0))

- Inferences: 26,901

- CPU Time: 0.003 seconds

- Wall Time: 0.003 seconds

5. **Test Case 5:**

- KB is as follows:

  - bottle1(g,g).

  - bottle2(e,v).

  - bottle3(e,v).

- Solution:

goal(result(pour(2,3),result(pour(3,2),result(pour(2,3),s0))))

- Inferences: 70,754

- CPU Time: 0.009 seconds

- Wall Time: 0.009 seconds
