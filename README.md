# 🚦 Traffic Light Controller – Asynchronous FSM with Formal Verification

## 🧭 Overview
This updated version of the Traffic Light Controller builds upon the earlier **timed FSM-based model** by introducing **asynchronous, event-driven logic** and **formal verification** techniques.  
It uses **Kripke Structure modeling** and **Computational Temporal Logic (CTL)** to formally verify correctness properties, ensuring safe and predictable traffic behavior before hardware synthesis.

The updated design allows **dynamic state transitions** triggered by a **button input**, simulating real-world sensor or pedestrian-based requests.  
Additionally, the design includes **synthesis analysis** to estimate **critical path delay, dynamic power, and resource utilization**, demonstrating a complete design–verify–analyze workflow.

---

## ⚙️ Key Improvements from the Previous Version

| Feature | Previous Version | Updated Version |
|----------|------------------|-----------------|
| **Design Type** | Synchronous FSM with fixed timer | Asynchronous FSM driven by input/button |
| **Control Input** | Emergency signal override | Event-triggered input (`button`) |
| **State Count** | 4 states | 5 states (`S0–S4`) including both-road red & side transitions |
| **Behavior** | Periodic time-based switching | On-demand side road activation |
| **Verification** | Functional simulation only | Formal verification with Kripke structure + CTL |
| **Analysis** | Behavioral simulation only | Added synthesis-level timing, power, and resource analysis |
| **Purpose** | Demonstration of FSM logic | Demonstration of verified, hardware-optimized control |

---

## 🔄 FSM Specification

The controller now includes **five defined states**:

| State | Description | Active Lights |
|:------|:-------------|:---------------|
| `S0` | Both Red (Idle) | Main = Red, Side = Red |
| `S1` | Main Yellow | Main = Yellow, Side = Red |
| `S2` | Main Green | Main = Green, Side = Red |
| `S3` | Side Yellow | Main = Red, Side = Yellow |
| `S4` | Side Green | Main = Red, Side = Green |

A **button input** acts as a trigger, allowing vehicles or pedestrians to request a green signal for the side road while maintaining mutual exclusion of greens between directions.

---

## 🧮 Formal Modeling & Verification

### 🔹 Kripke Structure
The FSM behavior is modeled as a **Kripke Structure (K = (S, R, L))**, where:
- `S` → Set of system states (`S0–S4`)
- `R` → Transition relations between states
- `L` → Labeling function mapping states to atomic propositions (e.g., “Main_Green,” “Side_Red”)

### 🔹 CTL Property Verification
Using **Computational Temporal Logic (CTL)**, critical system properties can be expressed as:

| Property | CTL Formula | Meaning |
|-----------|-------------|----------|
| **Safety** | `AG ¬(Main_Green ∧ Side_Green)` | Never both green simultaneously |
| **Liveness** | `AF Side_Green` | Eventually side road will get green |
| **Fairness** | `AG (Button → AF Side_Green)` | If button pressed, side green occurs eventually |

---

## 🧪 Simulation and Results

### 🖥 Console Output Snapshot
```
Time    State   Main(R,Y,G)   Side(R,Y,G)   Button
0       000     100           100           0
25000   010     001           100           0
65000   011     100           010           1
75000   100     100           001           0
...
```

- Button press during `Main Green` triggers transition to side road sequence (`S3 → S4`).  
- No conflicting green states observed.  
- FSM resumes normal sequence once side phase completes.

### 📊 Waveform Output
![Simulation Output](simulation_output.png)
![Waveform](waveform.png)

- Asynchronous button signal triggers side sequence instantly  
- Correct red-yellow-green alternation maintained  
- Safe mutual exclusion verified visually  

---

## ⚡ Hardware Synthesis Analysis

After implementing the design on an FPGA:
- **Critical Path Delay:** Measured to determine system clock limit  
- **Dynamic Power:** Estimated for switching activities  
- **Resource Usage:** LUTs, flip-flops, and combinational resources analyzed  

This provides hardware feasibility insights for real-world deployment.

---

## 🧩 Future Directions

🔹 Integrate **sensor-based adaptive control** (vehicle detection, traffic density inputs)  
🔹 Expand to a **4-way intersection** with synchronization logic  
🔹 Implement **priority scheduling** (ambulance/bus lanes)  
🔹 Add **pedestrian signals with countdown timers**  
🔹 Develop a **hardware-verified formal proof report** linking FSM states with CTL validation  

---

## 👨‍💻 Author
**Vishwas Jasuja**  
B.Tech in Microelectronics and VLSI, IIT Mandi  
*Designed, formally verified, and simulated using Verilog HDL and temporal logic concepts.*

📎 [GitHub Profile](https://github.com/VishwasJ05)
