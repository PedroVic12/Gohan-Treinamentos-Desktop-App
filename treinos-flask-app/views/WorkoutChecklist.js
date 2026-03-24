const { Checkbox, Button, Dialog, DialogTitle } = MaterialUI;

// ========= UTIL LOCALSTORAGE =========
function save(key, value) {
    localStorage.setItem(key, JSON.stringify(value));
}

function load(key, fallback) {
    const v = localStorage.getItem(key);
    return v ? JSON.parse(v) : fallback;
}

// ========= 3) CHECKLIST =========
function WorkoutChecklist({ exercise }) {
    const key = `series_${exercise}`;
    const [checked, setChecked] = React.useState(load(key, [false, false, false, false]));

    const toggle = (i) => {
        const updated = [...checked];
        updated[i] = !updated[i];
        setChecked(updated);
        save(key, updated);
    };

    return (
        <div>
            <h3>Checklist — {exercise}</h3>

            {checked.map((v, i) => (
                <Checkbox
                    key={i}
                    checked={v}
                    onChange={() => toggle(i)}
                    color="primary"
                />
            ))}
        </div>
    );
}

// ========= 4) TIMER MODAL =========
function RestTimerModal({ open, onClose }) {
    const [seconds, setSeconds] = React.useState(60);

    React.useEffect(() => {
        if (!open) return;
        setSeconds(60);
        const interval = setInterval(() => {
            setSeconds((s) => {
                if (s <= 1) {
                    clearInterval(interval);
                    onClose();
                }
                return s - 1;
            });
        }, 1000);
        return () => clearInterval(interval);
    }, [open]);

    return (
        <Dialog open={open} onClose={onClose}>
            <DialogTitle>Descanso: {seconds}s</DialogTitle>
            <Button onClick={onClose} color="secondary">
                Pular descanso
            </Button>
        </Dialog>
    );
}

// ========= ROOT APP =========
function App() {
    const [open, setOpen] = React.useState(false);

    return (
        <div>
            <h1>Treinos — React CDN + MUI 3</h1>

            <WorkoutChecklist exercise="Supino Reto" />

            <Button variant="contained" color="primary" onClick={() => setOpen(true)}>
                Iniciar Descanso
            </Button>

            <RestTimerModal open={open} onClose={() => setOpen(false)} />
        </div>
    );
}

ReactDOM.render(<App />, document.getElementById("root"));