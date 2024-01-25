---
title: Using a custom hook instead of useContext in React's Context API
date: 2023-09-17 11:09:37
categories: 文章
tags: english
---
Junior react devs should use a custom Hook instead of useContext to avoid prop drilling and easily access the theme in multiple components.
***

<!-- more -->
## example

Wrap the root component of your React app with a theme context provider to give all pages access to the theme, but be aware that only the provider itself needs to be a client component.

``` javascript
# /context/theme-context

import React, { createContext, useState } from 'react';

const ThemeContext = createContext(null);

export default function ThemeContextProvider({children}) {
  const [theme, setTheme] = useState('light')

  return (
    <ThemeContext.Provider
      value={{
        theme,
        setTheme
      }}
    >
      {children}
    </ThemeContext.Provider>
  )
}
```

the drawbacks of using the useContext hook for the Context API in React and suggests using a custom hook instead to avoid the need to manually import and specify the context in every component.

## Use Context API

```javascript
# logo.tsx
import { ThemeContext } from '@/context/theme-context';
import React, { useContext } from 'react';

export default function Logo() {
  const { theme, setTheme } = useContext(ThemeContext);
  // if theme is dark mode, return dark mode logo...

  // if theme is light mode, return light mode logo...
  return <div>Logo</div>
}

```

## Use a custom hook

Add a useThemeContext hook into theme-context

```javascript
......
type ThemeContextProviderProps = {
  children: React.ReactNode;
}

type Theme = 'dark' | 'light'

type ThemeContext = {
  theme: string;
  setTheme: React.Dispatch<React.SetStateAction<string>>;
}
export const ThemeContext = createContext<ThemeContext | null>(null)

export function useThemeContext(){
  const context = React.useContext(ThemeContext);
  if(context === undefined){
    throw new Error ("useThemeContext muse be used within a ThemeContextProvider")
  }
  return context;
}

```

And in the component, use like this:

```javascript
# logo.tsx
import { useThemeContext } from '@/context/theme-context';
import React, { useContext } from 'react';

export default function Logo() {
  const { theme, setTheme } = useThemeContext();
  // if theme is dark mode, return dark mode logo...

  // if theme is light mode, return light mode logo...
  return <div>Logo</div>
}
```

## summary

💡 One of the biggest mistakes that Junior react developers make is not using a custom Hook when they're using the context API.
🌳 The root layout component in React should wrap the entire app with the theme context provider to ensure that all components have access to it.
💡 The speaker suggests using a custom hook instead of the useContext hook for implementing the Context API in React, highlighting potential issues with the useContext approach.
🚫 It is recommended to use a custom hook for the Context API instead of useContext to avoid the problems associated with null values and improve code readability.
🚀 By abstracting the problems into a custom hook, it becomes immediately clear which context is being used, improving code readability and maintainability.
🤔 TypeScript can help prevent errors by specifying the specific type of a variable, such as using a Union type for a theme.
