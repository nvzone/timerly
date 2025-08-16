# Timerly
Eye candy interactive timer plugin for Neovim. Useful for those who spend large amount of time in Neovim. I code in Nvim and use it for work too so 10 hrs ~ at a busy day, the timer helps me with breaks and acts as a reminder to not sit for long hours!

https://github.com/user-attachments/assets/070b7e4d-abb3-462e-b4b1-a95f6143be58
 
## Install

```lua
{
  "nvzone/timerly",
  dependencies = 'nvzone/volt',
  cmd = "TimerlyToggle",
  opts = {} -- optional
},
```

- For config, check the [config table here](https://github.com/NvChad/timerly/blob/main/lua/timerly/state.lua#L12)

## Commands

- TimerlyToggle

## Mappings

- toggle mode: `m`
- toggle status: `<leader>`
- increment: `<up>`
- decrement: `<down>`
- reset: `<BS>`


## Using as a desktop app

https://github.com/user-attachments/assets/97ad6370-53eb-4760-96f4-5736ec001b68

- Add the Timer command in your Neovim config

```lua
vim.api.nvim_create_user_command("Timer", function()
  vim.o.showtabline = 0
  vim.o.laststatus = 0
  vim.wo.number = false
  vim.o.scl = "no"
  vim.o.cmdheight = 0
  vim.cmd "TimerlyToggle"
end, {})
```

- ~/.local/share/applications/timerly.desktop

```bash
[Desktop Entry]
Type=Application
Version=1.0
Name=Timerly
Icon=clockify
Exec=st -g 42x19 -e nvim +':Timer'
Terminal=false
Categories=Utility;System;ConsoleOnly
Keywords=timer;clock;time;task;
```


## :gift_heart: Support

If you like NvChad or its plugins and would like to support it via donation

[![kofi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/siduck)
[![paypal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://paypal.me/siduck13)
[![buymeacoffee](https://img.shields.io/badge/Buy_Me_A_Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/siduck)
[![patreon](https://img.shields.io/badge/Patreon-F96854?style=for-the-badge&logo=patreon&logoColor=white)](https://www.patreon.com/siduck)
