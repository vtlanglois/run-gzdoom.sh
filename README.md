# Run GZDoom Sh(ell)

A very simple GZDoom file manager. Built as an experiment in writing BASH scripts.

## Installation
1. Clone the repo: 
```
git clone https://github.com/vtlanglois/run-gzdoom.sh.git
```
2. Make the script executable: 
```
chmod +x /path/to/run-doom.sh
````
3. Create a `config.env` file based on `config.env.example`:
```
cp config.env.example config.env
```
4. Add your GZDoom path, your WAD path, and your mod path(s) to your local `config.env`
>[!NOTE]
> Set a mod as `Vanilla|none` to run your vanilla WAD instead.
5. Run it! 
```
./run-doom.sh
```

