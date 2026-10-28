# room_space

**One capability bit from GBT V8, packaged standalone.** No. 272 of 341,
`system` domain (System).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 镜像房间空间（**隔离排练现实**，主人令生产面红线：所有假设/模拟/推演/打磨一律在房间里跑，房间不覆盖全局 mirror_space/reality）：create/enter/define_plan/get_plan/frame/gate/namespace/shape/scan/simulate/parity/rehearse/release/sync/status/snapshot。**F12 补齐（2026-10-18 真接完）**：第一版只说"按唯一门接线"，实际 api.py 只路由了前八个；simulate/parity/rehearse/release 等八个原语模块里有、门上没有 ⇒ `gate` 永远报「没有房间排练报告」，房间正路走不完。本轮补齐后「排练 → 盖章 → 原子替换」才真能在门上闭环。

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-room-space.git
cd gbt-room-space
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_room_space info                  # capability card
python -m gbt_room_space spec --json           # machine-readable contract
python -m gbt_room_space check --payload '{}'
python -m gbt_room_space run   --payload '{}'
```

Real `info` output from this machine:

```text
room_space  (system)  v1.0.0
----------------------------------------
镜像房间空间（**隔离排练现实**，主人令生产面红线：所有假设/模拟/推演/打磨一律在房间里跑，房间不覆盖全局 mirror_space/reality）：create/enter/define_plan/get_plan/frame/gate/namespace/shape/scan/simulate/parity/rehearse/release/sync/status/snapshot。**F12 补齐（2026-10-18 真接完）**：第一版只说"按唯一门接线"，实际 api.py 只路由了前八个；simulate/parity/rehearse/release 等八个原语模块里有、门上没有 ⇒ `gate` 永远报「没有房间排练报告」，房间正路走不完。本轮补齐后「排练 → 盖章 → 原子替换」才真能在门上闭环。

gated      : True   <- needs explicit consent
external   : False
multi-op   : True
params     : (none)
values     : create, enter, define_plan, get_plan, frame, gate, namespace, shape, scan, simulate, parity, rehearse, release, sync, status, snapshot
```

Wire a real implementation:

```python
from gbt_room_space import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（16 个）**：`create`、`enter`、`define_plan`、`get_plan`、`frame`、`gate`、`namespace`、`shape`、`scan`、`simulate`、`parity`、`rehearse`、`release`、`sync`、`status`、`snapshot`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Gated: this bit is marked `safe: false` in the registry — it can change state that no inverse action restores.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.10s
```

## Provenance

| field | value |
|---|---|
| capability | `room_space` |
| domain | `system` |
| handler | `room_space` |
| safe | `False` (gated = `True`) |
| external | `False` |
| atlas page | [system/room_space](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/system/room_space.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
