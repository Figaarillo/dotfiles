# Notas generales del proyecto

Entre otras cosas, se tendrá notas hacerca de la estructura del proyecto, configuraciones, entre otras.

## Configuración de TypeScript

```js
{
    "compilerOptions": {
    /* Visit https://aka.ms/tsconfig to read more about this file */
    /* Projects */
    /* Language and Environment */
    "target": "es2016",                                  /* Set the JavaScript language version for emitted JavaScript and include compatible library declarations. */
    "experimentalDecorators": true,                      /* Enable experimental support for legacy experimental decorators. */
    /* Modules */
    "module": "commonjs",                                /* Specify what module code is generated. */
    /* JavaScript Support */
    /* Emit */
    "outDir": "./dist",                                   /* Specify an output folder for all emitted files. */
    /* Interop Constraints */
    "esModuleInterop": true,                             /* Emit additional JavaScript to ease support for importing CommonJS modules. This enables 'allowSyntheticDefaultImports' for type compatibility. */
    "forceConsistentCasingInFileNames": true,            /* Ensure that casing is correct in imports. */
    /* Type Checking */
    "strict": true,                                      /* Enable all strict type-checking options. */
    "strictPropertyInitialization": true,                /* Check for class properties that are declared but not set in the constructor. */
    /* Completeness */
    "skipLibCheck": true                                 /* Skip type checking all .d.ts files. */
  }
}
```

## Estructura del proyecto

```zsh
./
├── package.json
├── pnpm-lock.yaml
├── README.md
├── src
│   └── server.ts
└── tsconfig.json
```

```zsh
src/server.ts => para iniciar el servidor
```

## ¿Cómo instalar eslint?

```zsh
cat .zhistory | grep 'eslint'
pnpm add -D prettier eslint-config-prettier eslint-plugin-prettier
pnpm add -D prettier eslint-config-prettier eslint-plugin-prettier
pnpx eslint --init
cp  ~/Documents/Programacion/.eslint-personal-config/node-relax/* ./ -r
```
