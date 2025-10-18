<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Potato Hut v7.0 — Search & Themes!</title>
    
    <script src="https://cdn.tailwindcss.com"></script>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Comic+Sans+MS&family=Inter:wght@400;500;700;800&display=swap" rel="stylesheet">
    
    <script src="https://unpkg.com/phosphor-icons"></script>

    <style>
        /* Define fonts */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #FEFCF5; /* A warmer, lighter cream */
            color: #1f2937; /* default gray-800 */
            overflow-x: hidden;
            min-height: 100vh;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        
        /* The irony font */
        .font-comic {
            font-family: 'Comic Sans MS', cursive;
        }
        
        /* --- THEME STYLES --- */

        /* 1. Dark Theme */
        .theme-dark {
            background-color: #1a1a1a;
            color: #E0E0E0;
        }
        .theme-dark .card, .theme-dark header {
            background-color: #2a2a2a;
            color: #E0E0E0;
            border-color: #444;
        }
        .theme-dark .secondary-btn {
             background-color: #444;
             color: #E0E0E0;
        }
        .theme-dark .secondary-btn:hover { background-color: #555; }
        .theme-dark input, .theme-dark select, .theme-dark textarea {
            background-color: #333;
            color: #E0E0E0;
            border-color: #555;
        }
        .theme-dark ::placeholder { color: #888; }
        .theme-dark #main-header {
             background-color: rgba(30, 30, 30, 0.8);
             color: #E0E0E0;
        }

        .dark-mode-texture::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url('https://www.transparenttextures.com/patterns/natural-paper.png');
            opacity: 0.05;
            pointer-events: none;
        }
        
        /* 2. Corporate Theme */
        .theme-corporate { background-color: #f0f5fa; color: #334e68; }
        .theme-corporate .card { background-color: #ffffff; }
        .theme-corporate .primary-btn { background-color: #2563eb; }
        .theme-corporate .primary-btn:hover { background-color: #1d4ed8; }
        .theme-corporate .font-comic { color: #1e3a8a; }
        .theme-corporate #main-header { background-color: rgba(255, 255, 255, 0.8); }

        /* 3. Hacker Theme */
        .theme-hacker { background-color: #0d0d0d; color: #00ff41; font-family: 'Courier New', monospace; }
        .theme-hacker .card, .theme-hacker header { background-color: #1a1a1a; border: 1px solid #00ff41; color: #00ff41; }
        .theme-hacker .primary-btn { background-color: #00ff41; color: #000; font-family: 'Courier New', monospace; }
        .theme-hacker .primary-btn:hover { background-color: #33ff66; }
        .theme-hacker .font-comic { font-family: 'Courier New', monospace; color: #00ff41; }
        .theme-hacker input, .theme-hacker select, .theme-hacker textarea { background-color: #222; color: #00ff41; border: 1px solid #00ff41; }
        .theme-hacker ::placeholder { color: #00ff41; opacity: 0.5; }
        .theme-hacker .nav-link-active { color: #00ff41; border-color: #00ff41; }
        .theme-hacker .text-amber-800 { color: #00ff41; }
        .theme-hacker .text-amber-600 { color: #00cc33; }
        .theme-hacker #main-header { background-color: rgba(13, 13, 13, 0.8); }

        /* --- END THEMES --- */

        /* Hide pages by default, with a smoother fade-in */
        .page-content {
            display: none;
        }
        .page-content.active {
            display: block;
            animation: fadeIn 0.6s ease-in-out;
        }
        
        /* General UI Polish */
        .card {
            @apply bg-white p-6 rounded-xl shadow-md transition-all duration-300;
        }
        .card-hover:hover {
            @apply shadow-xl transform -translate-y-1;
        }
        .primary-btn {
            @apply bg-amber-800 text-white font-bold py-3 px-8 rounded-full text-lg hover:bg-amber-900 transform hover:scale-105 transition-all shadow-lg;
        }
        .primary-btn:disabled {
            @apply bg-gray-400 opacity-70 cursor-not-allowed transform-none shadow-none;
        }
        .secondary-btn {
            @apply bg-gray-200 text-gray-800 font-bold py-3 px-8 rounded-full text-lg hover:bg-gray-300 transition-all;
        }
        .nav-link-active {
            color: #92400e; /* amber-800 */
            font-weight: 700;
            border-bottom: 2px solid #92400e;
        }

        /* Loading Screen Styles */
        #loading-screen {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: #fefcf5;
            z-index: 100000;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: opacity 0.5s ease-out;
        }
        #loading-spinner {
            border: 8px solid #f3f3f3;
            border-top: 8px solid #92400e;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Notification Toast styles */
        #notification-toast {
            transition: transform 0.4s cubic-bezier(0.25, 1, 0.5, 1);
        }
        #notification-toast.show { transform: translateX(0); }
        #notification-toast.success { background-color: #22c55e; color: white; }
        #notification-toast.error { background-color: #ef4444; color: white; }
        #notification-toast.info { background-color: #3b82f6; color: white; }
        
        /* Other Animations */
        @keyframes explode {
            0% { transform: scale(1) rotate(0deg); opacity: 1; }
            50% { transform: scale(3) rotate(180deg); opacity: 0; }
            100% { transform: scale(1) rotate(360deg); opacity: 1; }
        }
        .explode-animation { animation: explode 0.7s ease-out; }
        @keyframes draw-line { to { stroke-dashoffset: 0; } }
        .stock-graph-line {
            stroke-dasharray: 1000;
            stroke-dashoffset: 1000;
            animation: draw-line 2s forwards ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes bounce {
          0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
          40% { transform: translateY(-30px); }
          60% { transform: translateY(-15px); }
        }
        .bouncing-potato {
            position: fixed; font-size: 3rem; animation: bounce 2s infinite;
            z-index: 9999; pointer-events: none;
        }
        #spuddy-follower {
            position: fixed; font-size: 2rem; pointer-events: none;
            transition: transform 0.1s ease-out; z-index: 10000;
        }
        #spuddy-chat-window { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); }
        
        /* Google Easter Egg Visual */
        #konami-surprise {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.9); z-index: 99999; display: none;
            align-items: center; justify-content: center; color: white;
            font-size: 4rem; text-align: center; flex-direction: column;
        }
        .g-logo-color { font-size: 6rem; }
        .g-blue { color: #4285F4; }
        .g-red { color: #DB4437; }
        .g-yellow { color: #F4B400; }
        .g-green { color: #0F9D58; }

        /* NEW: Cursed Mode Styles */
        .theme-cursed .gallery-item img {
            filter: hue-rotate(180deg) invert(0.8) sepia(0.5);
            transform: rotate(2deg) scale(1.02);
            transition: all 0.3s ease;
        }
        .theme-cursed .gallery-item p {
            font-family: 'Comic Sans MS', cursive;
            color: red;
            font-weight: bold;
        }
        
        /* NEW: Potato Clicker Styles */
        #clicker-potato {
            font-size: 10rem;
            cursor: pointer;
            user-select: none;
            transition: transform 0.1s ease-out;
        }
        #clicker-potato:active {
            transform: scale(0.9);
        }
        .clicker-upgrade-btn {
            @apply w-full bg-amber-600 text-white p-3 rounded-lg hover:bg-amber-700 disabled:bg-gray-400;
        }
        
        /* NEW: Cash Rain Styles */
        .cash-money {
            position: fixed;
            font-size: 2rem;
            animation: fall 3s linear forwards;
            pointer-events: none;
            z-index: 99999;
        }
        @keyframes fall { 
            0% { top: -10%; opacity: 1; } 
            100% { top: 110%; opacity: 0; } 
        }

    </style>
</head>
<body class="antialiased">

    <audio id="boiling-audio" loop>
        <source src="https://www.soundjay.com/nature/sounds/boiling-water-1.mp3" type="audio/mpeg">
    </audio>

    <div id="loading-screen">
        <div id="loading-spinner"></div>
        <p class="mt-4 text-xl font-comic text-amber-800">Simulating existence... (Please wait for the starch to fully mash)</p>
    </div>

    <div id="dark-mode-overlay" class=""></div>

    <div id="spuddy-follower" class="hidden">🥔</div>

    <div id="konami-surprise">
        <div class="flex">
            <span class="g-logo-color g-blue">G</span>
            <span class="g-logo-color g-red">o</span>
            <span class="g-logo-color g-yellow">o</span>
            <span class="g-logo-color g-blue">g</span>
            <span class="g-logo-color g-green">l</span>
            <span class="g-logo-color g-red">e</span>
            <span class="text-white text-5xl ml-4">Easter Egg!</span>
        </div>
        <p class="text-lg mt-8 text-gray-300">You unlocked the Google-approved 🥔-mode.</p>
        <button onclick="document.getElementById('konami-surprise').style.display = 'none';" class="primary-btn mt-6">Continue the Mashed Life</button>
    </div>

    <div class="min-h-screen flex flex-col">
        <header id="main-header" class="bg-white/80 backdrop-blur-lg shadow-sm sticky top-0 z-40 w-full transition-colors duration-300">
            <div class="container mx-auto px-4 h-20 flex items-center justify-between">
                <a href="#home" id="logo" class="nav-link flex items-center space-x-3 cursor-pointer z-10">
                    <span class="text-4xl">🥔</span>
                    <div class="flex flex-col">
                        <h1 class="font-comic text-2xl font-bold text-amber-800">Potato Hut v7.0</h1>
                        <p class="text-xs text-amber-600 -mt-1">"Search & Themes!"</p>
                    </div>
                </a>
                
                <nav id="main-nav" class="hidden lg:flex items-center space-x-8">
                    <a href="#home" class="nav-link text-gray-600 hover:text-amber-700 transition-colors" id="home-nav-link">Home</a>
                    <a href="#products" class="nav-link text-gray-600 hover:text-amber-700 transition-colors">Products</a>
                    <a href="#invest" class="nav-link text-gray-600 hover:text-amber-700 transition-colors">Buy Potato Stocks 💰</a>
                    <a href="#news" class="nav-link text-gray-600 hover:text-amber-700 transition-colors">News</a>
                    <a href="#games" class="nav-link text-gray-600 hover:text-amber-700 transition-colors">Games</a>
                    <div class="relative group -my-5 py-5">
                        <button class="text-gray-600 hover:text-amber-700 transition-colors flex items-center">More <svg class="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg></button>
                        <div class="absolute right-0 top-full pt-2 w-48 bg-white rounded-md shadow-lg py-1 opacity-0 group-hover:opacity-100 transition-opacity duration-300 pointer-events-none group-hover:pointer-events-auto">
                           <a href="#gallery" class="nav-link block px-4 py-2 text-sm text-gray-700 hover:bg-amber-100">Gallery / Memes</a>
                           <a href="#translator" class="nav-link block px-4 py-2 text-sm text-gray-700 hover:bg-amber-100">Translator</a>
                           <a href="#membership" class="nav-link block px-4 py-2 text-sm text-gray-700 hover:bg-amber-100">Membership</a>
                           <a href="#about" class="nav-link block px-4 py-2 text-sm text-gray-700 hover:bg-amber-100">About Us</a>
                           <a href="#legal" class="nav-link block px-4 py-2 text-sm text-gray-700 hover:bg-amber-100">Terms / Legal</a>
                           <a href="#secret-lab" class="nav-link hidden block px-4 py-2 text-sm text-red-500 hover:bg-red-100" id="secret-lab-link">Secret Lab</a>
                        </div>
                    </div>
                </nav>
                
                <div class="flex items-center space-x-4 z-10">
                    <div class="relative hidden md:block">
                        <input type="text" id="main-search-input" placeholder="Search... (Try 'potato')" class="bg-gray-100 border-transparent rounded-full pl-10 pr-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400 transition-all w-32 focus:w-48">
                        <svg class="w-5 h-5 absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path></svg>
                        <button id="voice-search" aria-label="Voice Search" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 hover:text-amber-600">
                           <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path d="M3 5a2 2 0 012-2h1.414a2 2 0 011.414.586l1.414 1.414A2 2 0 0110.121 6H14a2 2 0 012 2v6a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm11 11a1 1 0 10-2 0v-1a1 1 0 102 0v1zm-3-12a1 1 0 10-2 0v1a1 1 0 102 0V4zM8 8a1 1 0 00-1 1v1a1 1 0 102 0V9a1 1 0 00-1-1z" /></svg>
                        </button>
                    </div>
                    <a href="#cart" class="nav-link relative" aria-label="View Cart"><svg class="w-7 h-7 hover:text-amber-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path></svg><span id="cart-count" class="absolute -top-1 -right-2 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center font-bold">0</span></a>
                    <a href="#chatbot" class="nav-link" id="spuddy-nav-icon" aria-label="Open Chatbot"><span class="text-3xl hover:animate-bounce">🤖</span></a>
                    <a href="#settings" class="nav-link text-2xl text-gray-600 hover:text-amber-700" aria-label="Settings">⚙️</a>
                </div>
                
                <button id="mobile-menu-btn" aria-label="Open Menu" class="lg:hidden text-3xl z-20">☰</button>
            </div>
             <div id="mobile-menu" class="hidden lg:hidden bg-white/95 absolute top-full left-0 w-full shadow-lg">
                <nav class="flex flex-col items-center space-y-4 py-4">
                     <a href="#home" class="nav-link text-lg text-gray-700">Home</a>
                     <a href="#products" class="nav-link text-lg text-gray-700">Products</a>
                     <a href="#invest" class="nav-link text-lg text-gray-700">Buy Potato Stocks 💰</a>
                     <a href="#news" class="nav-link text-lg text-gray-700">News</a>
                     <a href="#games" class="nav-link text-lg text-gray-700">Games</a>
                     <a href="#settings" class="nav-link text-lg text-gray-700">Settings ⚙️</a>
                     <a href="#gallery" class="nav-link text-lg text-gray-700">Gallery</a>
                     <a href="#translator" class="nav-link text-lg text-gray-700">Translator</a>
                     <a href="#membership" class="nav-link text-lg text-gray-700">Membership</a>
                     <a href="#about" class="nav-link text-lg text-gray-700">About</a>
                     <a href="#legal" class="nav-link text-lg text-gray-700">Legal</a>
                </nav>
            </div>
        </header>

        <main class="flex-grow container mx-auto p-4 md:p-8">
            
            <section id="page-home" class="page-content active">
                <div class="text-center py-24 md:py-40">
                    <div class="relative z-10 p-4 rounded-lg">
                        <h2 class="text-5xl md:text-7xl font-extrabold font-comic text-amber-900 drop-shadow-sm">Welcome to the Future of Useless.</h2>
                        <p id="tagline" class="mt-4 text-xl md:text-2xl text-gray-600 max-w-2xl mx-auto transition-opacity duration-500">Delivering imaginary innovation since 1842.</p>
                        <div class="mt-12 flex flex-col sm:flex-row items-center justify-center space-y-4 sm:space-y-0 sm:space-x-4">
                            <a href="#products" class="nav-link primary-btn">Shop Now (Regret Later)</a>
                            <a href="#chatbot" class="nav-link secondary-btn">Meet Spuddy</a>
                        </div>
                    </div>
                </div>
            </section>
            
            <section id="page-products" class="page-content">
                 <div class="text-center mb-12">
                    <h2 class="text-4xl font-bold font-comic">Our Useless Products</h2>
                    <p class="text-gray-600 mt-2">Sorting by: <select id="product-sort" class="rounded border-gray-300 shadow-sm"><option>Most Useless</option><option>Most Confusing</option><option>Highest Regret</option></select></p>
                </div>
                <div id="product-grid" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                    </div>
            </section>

            <section id="page-cart" class="page-content">
                <div class="max-w-3xl mx-auto card">
                    <h2 class="text-3xl font-bold mb-6 text-center">Your Imaginary Cart</h2>
                    <div id="cart-items" class="space-y-4 mb-6 min-h-[100px]">
                        <p class="text-center text-gray-500">Your cart seems to be adding things on its own...</p>
                    </div>
                    <div class="border-t pt-6">
                        <div class="flex justify-between items-center text-2xl font-bold">
                            <span>Total:</span>
                            <span id="cart-total" class="font-mono">$404.04</span>
                        </div>
                        <button id="checkout-btn" class="w-full mt-6 bg-green-500 text-white font-bold py-3 px-6 rounded-lg text-lg hover:bg-green-600 transition-transform transform hover:scale-105">
                            Proceed to Payment
                        </button>
                        <div id="checkout-spinner" class="hidden text-center mt-4">
                            <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-green-500"></div>
                            <p>Processing starch transfer...</p>
                        </div>
                    </div>
                    <div id="cart-empty-message" class="hidden text-center mt-8">
                        <span class="text-6xl">🥔</span>
                        <p class="text-xl text-gray-600">"Fill me with purpose."</p>
                    </div>
                    <div id="receipt" class="hidden mt-8 p-4 border-dashed border-2 border-gray-400 bg-gray-50 rounded-lg">
                        <h3 class="font-bold text-center font-mono">RECEIPT</h3>
                        <pre class="text-xs font-mono whitespace-pre-wrap text-center overflow-auto" id="receipt-art"></pre>
                    </div>
                </div>
            </section>
            
            <section id="page-invest" class="page-content">
                <div class="text-center mb-8">
                    <h2 class="text-4xl font-bold font-comic text-green-700">Buy Potato Stocks 🥔💰</h2>
                    <p class="text-gray-600">Invest in volatility. Gamble responsibly. Or don't.</p>
                </div>
                
                <div class="bg-gray-800 text-white p-6 rounded-xl shadow-2xl max-w-5xl mx-auto mb-8 relative">
                    <div class="flex flex-wrap justify-between items-center mb-4 gap-4">
                        <h3 class="text-2xl">Potato Index: <span id="potato-index" class="font-mono">1,234.56</span></h3>
                        <div id="stock-change" class="text-2xl font-bold text-green-400">+12.34 (1.01%)</div>
                    </div>
                    <div class="bg-gray-900 rounded-lg p-4 h-64 md:h-96 relative">
                        <svg id="stock-chart" class="w-full h-full" preserveAspectRatio="none" viewBox="0 0 400 160"></svg>
                        <div id="stock-tooltip" class="absolute bg-white text-black p-2 rounded text-xs pointer-events-none opacity-0 transition-opacity">Tooltip</div>
                    </div>
                    <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-5 gap-4 mt-6 text-center" id="live-ticker-prices">
                        <div><h4 class="font-bold text-lg">🥔 PHUT</h4><p class="text-green-400 font-mono">150.23</p></div>
                        <div><h4 class="font-bold text-lg">🍟 FRYT</h4><p class="text-red-400 font-mono">88.12</p></div>
                        <div><h4 class="font-bold text-lg">🧈 BTRR</h4><p class="text-green-400 font-mono">230.99</p></div>
                        <div><h4 class="font-bold text-lg">💧 DWAT</h4><p class="text-red-400 font-mono">0.01</p></div>
                        <div><h4 class="font-bold text-lg">🪫 AIRL</h4><p class="text-green-400 font-mono">5.67</p></div>
                    </div>
                    <div class="mt-6 text-center">
                        <input id="buy-spuds-input" type="text" placeholder="Type 'BUY SPUDS' for cash rain 💸" class="bg-gray-700 text-center rounded-full px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400">
                    </div>
                    <div id="raining-cash" class="absolute inset-0 pointer-events-none overflow-hidden"></div>
                </div>

                <div class="max-w-4xl mx-auto grid grid-cols-1 md:grid-cols-3 gap-8 mt-8">
                    <div class="card md:col-span-2">
                        <h3 class="text-2xl font-bold mb-4">Your Portfolio (Wallet)</h3>
                        <div class="space-y-3">
                            <div class="flex justify-between items-center text-xl border-b pb-2">
                                <span>Cash:</span>
                                <span id="user-cash" class="font-mono text-green-600 font-bold">$10,000.00</span>
                            </div>
                            <div class="flex justify-between items-center text-xl border-b pb-2">
                                <span>PotatoCoins:</span>
                                <span id="user-potatocoins" class="font-mono text-yellow-600 font-bold">0.0000 P₵</span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span>PotatoCoin (PHUT):</span>
                                <span id="held-phut" class="font-mono">0 PHUT</span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span>FrytCoin (FRYT):</span>
                                <span id="held-fryt" class="font-mono">0 FRYT</span>
                            </div>
                            <div class="pt-4 border-t-2 mt-4 flex justify-between items-center text-2xl font-bold">
                                <span>Net Worth:</span>
                                <span id="net-worth" class="font-mono text-blue-600">$10,000.00</span>
                            </div>
                        </div>
                    </div>

                    <div class="card bg-gray-100">
                        <h3 class="text-2xl font-bold mb-4">Trade Simulator</h3>
                        <div class="space-y-4">
                            <select id="trade-asset" class="w-full rounded-lg border-gray-300 shadow-sm p-2">
                                <option value="PHUT">PotatoCoin (PHUT)</option>
                                <option value="FRYT">FrytCoin (FRYT)</option>
                            </select>
                            
                            <input type="number" id="trade-quantity" placeholder="Quantity (e.g., 10)" min="1" value="1" class="w-full rounded-lg border-gray-300 shadow-sm p-2 focus:ring-2 focus:ring-amber-400">

                            <div class="flex space-x-2">
                                <button id="buy-btn" class="w-1/2 bg-green-500 text-white font-bold py-3 rounded-lg hover:bg-green-600 transition-colors">Buy</button>
                                <button id="sell-btn" class="w-1/2 bg-red-500 text-white font-bold py-3 rounded-lg hover:bg-red-600 transition-colors">Sell</button>
                            </div>
                        </div>
                        <p id="trade-message" class="text-center mt-4 text-sm text-gray-700 min-h-[20px]"></p>
                    </div>
                </div>
            </section>
            
            <section id="page-settings" class="page-content">
                <div class="text-center mb-8">
                    <h2 class="text-4xl font-bold font-comic">Spuddy Settings Center ⚙️</h2>
                    <p class="text-gray-600">Customize your inevitable regret.</p>
                </div>

                <div class="max-w-3xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-8">
                    <div class="card">
                        <h3 class="font-bold text-2xl mb-4 border-b pb-2">Appearance</h3>
                        <div class="space-y-4">
                            <div class="flex justify-between items-center">
                                <label class="font-semibold">Site Theme</label>
                                <select id="theme-selector" class="rounded border-gray-300 shadow-sm p-1">
                                    <option value="default">Default (Warm Cream)</option>
                                    <option value="dark">Dark Mode</option>
                                    <option value="corporate">Corporate Blue</option>
                                    <option value="hacker">Hacker (Green)</option>
                                </select>
                            </div>
                            <div class="flex justify-between items-center">
                                <label class="font-semibold">Toggle Dark Mode</label>
                                <button id="dark-mode-toggle" class="secondary-btn py-1 px-4">Switch Theme</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <h3 class="font-bold text-2xl mb-4 border-b pb-2">Potato Experience™</h3>
                        <div class="space-y-4">
                            <label class="flex justify-between items-center cursor-pointer">
                                <span class="font-semibold">Enable All-Potato Mode</span>
                                <input type="checkbox" id="potato-mode-toggle" class="h-5 w-5 rounded text-amber-600 focus:ring-amber-500">
                            </label>
                            <label class="flex justify-between items-center cursor-pointer">
                                <span class="font-semibold">Enable Boiling Sounds</span>
                                <input type="checkbox" id="boiling-sounds-toggle" class="h-5 w-5 rounded text-amber-600 focus:ring-amber-500">
                            </label>
                            <label class="flex justify-between items-center cursor-pointer">
                                <span class="font-semibold">Spuddy Follows Cursor</span>
                                <input type="checkbox" id="spuddy-follow-toggle" class="h-5 w-5 rounded text-amber-600 focus:ring-amber-500">
                            </label>
                             <label class="flex justify-between items-center cursor-pointer">
                                <span class="font-semibold text-red-500">Lag Simulator™</span>
                                <input type="checkbox" id="lag-sim-toggle" class="h-5 w-5 rounded text-amber-600 focus:ring-amber-500">
                            </label>
                        </div>
                    </div>
                </div>
            </section>

            <section id="page-news" class="page-content">
                <div class="text-center mb-8">
                    <h2 class="text-5xl font-bold font-comic text-red-700">PNN 2.0</h2>
                    <p class="text-gray-600">All The News That's Fit To Fry.</p>
                </div>
                <div class="card shadow-2xl max-w-4xl mx-auto">
                    <div class="flex justify-between items-center border-b-2 border-red-700 pb-2 mb-4">
                        <h3 class="text-2xl font-bold">Top Stories</h3>
                        <div id="breaking-boil" class="hidden animate-pulse">
                            <span class="bg-red-600 text-white font-bold p-2 rounded">BREAKING BOIL 🥔</span>
                        </div>
                    </div>
                    <div id="news-headlines" class="space-y-4">
                        </div>
                </div>
                <div class="mt-4 text-center text-sm text-gray-500">
                    <p>Click the news ticker 3 times for... secrets.</p>
                </div>
            </section>

            <section id="page-games" class="page-content">
                <div class="text-center mb-8">
                    <h2 class="text-4xl font-bold font-comic">Games Arcade</h2>
                    <p class="text-gray-600">Play games to earn PotatoCoins (P₵)!</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="card md:col-span-1">
                        <h3 class="text-2xl font-bold text-center">Catch the Potato</h3>
                        <p class="text-center text-gray-500 mb-4 text-sm">Click the 🥔! 15 seconds.</p>
                        
                        <div id="catch-game-area" class="relative w-full h-64 bg-gray-800 rounded-lg overflow-hidden cursor-crosshair border-4 border-gray-900" style="background-image: url('https://www.transparenttextures.com/patterns/stardust.png');">
                            <div id="catch-game-potato" class="absolute text-5xl cursor-pointer select-none" style="display: none; top: 50%; left: 50%; user-select: none;">🥔</div>
                        </div>
                        
                        <div class="flex justify-between items-center mt-4">
                            <button id="start-catch-game-btn" class="primary-btn py-2 px-6 text-base">Start</button>
                            <div class="text-right">
                                <p class="text-lg font-bold">Score: <span id="catch-game-score">0</span></p>
                                <p class="text-base">Time: <span id="catch-game-time">15</span>s</p>
                                <p class="text-xs text-gray-500">High Score: <span id="catch-game-high-score">0</span></p>
                            </div>
                        </div>
                    </div>

                    <div class="card md:col-span-2">
                        <h3 class="text-2xl font-bold text-center">Potato Clicker</h3>
                        <p class="text-center text-gray-500 mb-4 text-sm">Mash. Acquire. Ascend.</p>
                        
                        <div class="grid grid-cols-3 gap-4">
                            <div class="col-span-1 text-center flex flex-col items-center justify-center">
                                <div id="clicker-potato">🥔</div>
                                <p class_="text-sm text-gray-500">Mash me!</p>
                            </div>
                            
                            <div class="col-span-2 bg-gray-100 p-4 rounded-lg">
                                <h4 class="text-lg font-bold">Stats</h4>
                                <p class="text-2xl font-mono" id="clicker-potato-count">0</p>
                                <p class="text-gray-600">Mashed Potatoes</p>
                                <p class="text-lg font-mono mt-2" id="clicker-pps-count">0.0</p>
                                <p class="text-gray-600">Potatoes Per Second (PPS)</p>
                            </div>
                            
                            <div class="col-span-3 border-t pt-4 mt-4">
                                <h4 class="text-lg font-bold text-center mb-2">Upgrades</h4>
                                <div class="space-y-2">
                                    <button id="buy-auto-masher" class="clicker-upgrade-btn">
                                        Auto-Masher (+0.1 PPS)
                                        <span class_="block text-xs" id="auto-masher-cost">Cost: 10 Potatoes</span>
                                        <span class="block text-xs font-bold" id="auto-masher-level">Level: 0</span>
                                    </button>
                                    <button id="buy-spuddy-helper" class="clicker-upgrade-btn">
                                        Spuddy's Helper (+1 PPS)
                                        <span class="block text-xs" id="spuddy-helper-cost">Cost: 100 Potatoes</span>
                                        <span class="block text-xs font-bold" id="spuddy-helper-level">Level: 0</span>
                                    </button>
                                    <button id="buy-potato-farm" class="clicker-upgrade-btn">
                                        Potato Farm (+10 PPS)
                                        <span class="block text-xs" id="potato-farm-cost">Cost: 1000 Potatoes</span>
                                        <span class="block text-xs font-bold" id="potato-farm-level">Level: 0</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card card-hover opacity-60 md:col-span-3">
                        <p class="text-6xl mb-4 text-center">💥</p>
                        <h3 class="text-2xl font-bold text-center">Potato Pong</h3>
                        <p class="text-gray-500 my-4 text-center">The ball randomly explodes.</p>
                        <button class="block mx-auto bg-red-600 text-white px-6 py-2 rounded-full font-semibold opacity-50 cursor-not-allowed">Play (Soon™)</button>
                    </div>
                </div>
            </section>
            <section id="page-translator" class="page-content">
                <div class="text-center">
                    <h2 class="text-4xl font-bold font-comic">Potato Translator Hub</h2>
                    <p class="text-gray-600 mb-8">Speak the language of the tubers.</p>
                </div>
                <div class="max-w-4xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-8">
                    <div class="card">
                        <h3 class="font-bold text-xl mb-2">Human Tongue ➡️ Potato Speak</h3>
                        <textarea id="human-input" class="w-full h-40 border border-gray-300 rounded-md p-2 focus:ring-2 focus:ring-amber-400 focus:border-transparent" placeholder="Type anything here..."></textarea>
                    </div>
                    <div class="bg-gray-800 p-6 rounded-xl shadow-lg text-white">
                        <h3 class="font-bold text-xl mb-2">🥔🍠 Translation</h3>
                        <div id="potato-output" class="w-full h-40 bg-gray-700 rounded-md p-2 font-mono text-2xl break-words"></div>
                    </div>
                </div>
                <div class="max-w-4xl mx-auto mt-6 flex items-center justify-center space-x-4 bg-gray-100 p-4 rounded-lg">
                    <label class="font-semibold">Options:</label>
                    <select class="rounded border-gray-300 shadow-sm">
                        <option>Casual Tone</option><option>Business Tone</option><option>Ancient Tubertongue</option>
                    </select>
                    <label class="flex items-center"><input type="checkbox" id="auto-mash-mode" class="mr-2 h-4 w-4 rounded text-amber-600 focus:ring-amber-500">Auto-Mash</label>
                    <label class="flex items-center"><input type="checkbox" id="deep-fry-mode" class="mr-2 h-4 w-4 rounded text-amber-600 focus:ring-amber-500">Deep Fry</label>
                </div>
                 <div id="bouncing-potatoes-container"></div>
            </section>

            <section id="page-membership" class="page-content">
                <div class="text-center">
                    <h2 class="text-4xl font-bold font-comic">The Tuber Club</h2>
                    <p class="text-gray-600 mb-8 max-w-xl mx-auto">Where your loyalty is rewarded with absolutely nothing of value, but with fancier names.</p>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                    <div class="card card-hover text-center border-2 border-yellow-700 bg-yellow-50">
                        <h3 class="text-2xl font-bold">Bronze Tater 🥉</h3>
                        <p class="my-4 text-gray-600">Minimal benefits.</p>
                        <button class="bg-yellow-700 text-white px-6 py-2 rounded-full">Join Now</button>
                    </div>
                    <div class="card card-hover text-center border-2 border-gray-400 bg-gray-50">
                        <h3 class="text-2xl font-bold">Silver Chip 🥈</h3>
                        <p class="my-4 text-gray-600">Slightly crispier access.</p>
                        <button class="bg-gray-500 text-white px-6 py-2 rounded-full">Upgrade</button>
                    </div>
                    <div class="card card-hover text-center border-2 border-amber-500 bg-amber-50">
                        <h3 class="text-2xl font-bold">Gold Mash 🥇</h3>
                        <p class="my-4 text-gray-600">Golden but pointless.</p>
                        <button class="bg-amber-500 text-white px-6 py-2 rounded-full">Go For Gold</button>
                    </div>
                    <div class="card card-hover text-center border-2 border-blue-500 bg-blue-50 relative overflow-hidden">
                        <div class="absolute -top-10 -right-10 text-5xl transform rotate-45 text-blue-500/20">💎</div>
                        <h3 class="text-2xl font-bold">Ultra Mash 💎</h3>
                        <p class="my-4 text-gray-600">Receive nothing, faster.</p>
                        <button class="bg-blue-500 text-white px-6 py-2 rounded-full">Ascend</button>
                    </div>
                </div>
                 <div class="mt-12 card max-w-2xl mx-auto">
                    <h3 class="text-2xl font-bold text-center mb-6">Your Dashboard</h3>
                    <div class="space-y-6">
                        <div>
                            <label class="font-semibold text-gray-700">Starch Level</label>
                            <div class="w-full bg-gray-200 rounded-full h-4 mt-1"><div class="bg-yellow-400 h-4 rounded-full" style="width: 45%"></div></div>
                        </div>
                        <div>
                            <label class="font-semibold text-gray-700">Regret XP</label>
                            <div class="w-full bg-gray-200 rounded-full h-4 mt-1"><div class="bg-red-500 h-4 rounded-full" style="width: 72%"></div></div>
                        </div>
                    </div>
                    <div class="mt-8 pt-6 border-t text-center">
                        <h4 class="font-bold text-lg">Unlockables</h4>
                        <p class="text-gray-500 mt-2">✅ Spuddy Wallpapers (Coming Soon™)</p>
                        <p class="text-gray-500">✅ Early access to future delays</p>
                        <p class="text-gray-500">✅ PotatoCoin Beta (backed by imagination)</p>
                    </div>
                 </div>
            </section>
            
            <section id="page-gallery" class="page-content">
                <div class="text-center mb-8">
                    <h2 class="text-4xl font-bold font-comic">Gallery / Meme Vault</h2>
                </div>
                <div class="flex justify-center mb-4 border-b">
                    <button class="px-6 py-2 border-b-2 border-amber-500 font-bold">Memes</button>
                    <button class="px-6 py-2 text-gray-500 hover:border-b-2 hover:border-gray-300">Fan Art</button>
                    <button class="px-6 py-2 text-gray-500 hover:border-b-2 hover:border-gray-300">Real Potatoes</button>
                </div>
                 <div class="text-center my-6">
                    <label class="flex items-center justify-center cursor-pointer"><input type="checkbox" id="cursed-mode" class="mr-2 h-4 w-4 rounded text-amber-600 focus:ring-amber-500">Enable Cursed Mode</label>
                </div>
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                    <div class="bg-white p-2 rounded-lg shadow-md gallery-item transition-all duration-500">
                        <img src="https://placehold.co/400x400/FFF176/000000?text=Meme" class="w-full h-auto rounded-md" alt="A Potato Meme">
                        <p class="text-sm text-gray-600 mt-2 p-1">AI Caption: A potato doing its best.</p>
                    </div>
                    <div class="bg-white p-2 rounded-lg shadow-md gallery-item transition-all duration-500">
                        <img src="https://placehold.co/400x400/FFB74D/000000?text=Meme" class="w-full h-auto rounded-md" alt="A Potato Meme">
                        <p class="text-sm text-gray-600 mt-2 p-1">AI Caption: This is, indeed, a potato.</p>
                    </div>
                     <div class="bg-white p-2 rounded-lg shadow-md gallery-item transition-all duration-500">
                        <img src="https://placehold.co/400x400/FF8A65/000000?text=Meme" class="w-full h-auto rounded-md" alt="A Potato Meme">
                        <p class="text-sm text-gray-600 mt-2 p-1">AI Caption: Starch-based lifeform.</p>
                    </div>
                    <div class="bg-white p-2 rounded-lg shadow-md gallery-item transition-all duration-500">
                        <img src="https://placehold.co/400x400/AED581/000000?text=Meme" class="w-full h-auto rounded-md" alt="A Potato Meme">
                        <p class="text-sm text-gray-600 mt-2 p-1">AI Caption: Contemplating existence.</p>
                    </div>
                </div>
                <div class="mt-12 text-center bg-gray-100 p-6 rounded-lg">
                    <h3 class="font-bold text-xl">Upload Your Masterpiece</h3>
                    <input type="file" class="mt-4 block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-amber-50 file:text-amber-700 hover:file:bg-amber-100">
                    <button class="bg-blue-500 text-white px-6 py-2 rounded-full mt-4 font-semibold">Upload (It won't work)</button>
                </div>
            </section>

            <section id="page-about" class="page-content">
                <div class="max-w-3xl mx-auto text-center">
                    <h2 class="text-4xl font-bold font-comic">About Us</h2>
                    <p class="text-xl text-gray-600 mt-2">"Why fix it when it can stay mashed?"</p>
                </div>
                <div class="mt-12 max-w-4xl mx-auto">
                    <h3 class="text-2xl font-bold text-center mb-8">Meet the Team</h3>
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-8">
                        <div class="text-center team-member">
                            <img src="https://placehold.co/200x200/d1a370/FFFFFF?text=🥔" class="w-32 h-32 rounded-full mx-auto shadow-lg border-4 border-white transform hover:scale-110 transition-transform duration-300">
                            <h4 class="font-bold mt-4 text-lg">Spudrick Spuddington</h4>
                            <p class="text-sm text-gray-500 bio">Chief Executive Tuber</p>
                        </div>
                        <div class="text-center team-member">
                            <img src="https://placehold.co/200x200/c28e5f/FFFFFF?text=🥔" class="w-32 h-32 rounded-full mx-auto shadow-lg border-4 border-white transform hover:scale-110 transition-transform duration-300">
                            <h4 class="font-bold mt-4 text-lg">Mashall McTuber</h4>
                            <p class="text-sm text-gray-500 bio">Head of Imaginary Innovation</p>
                        </div>
                        <div class="text-center team-member">
                            <img src="https://placehold.co/200x200/e0b887/FFFFFF?text=🥔" class="w-32 h-32 rounded-full mx-auto shadow-lg border-4 border-white transform hover:scale-110 transition-transform duration-300">
                            <h4 class="font-bold mt-4 text-lg">Chip Chipserson</h4>
                            <p class="text-sm text-gray-500 bio">VP of Pointless Products</p>
                        </div>
                        <div class="text-center team-member">
                            <img src="https://placehold.co/200x200/b57d4a/FFFFFF?text=🥔" class="w-32 h-32 rounded-full mx-auto shadow-lg border-4 border-white transform hover:scale-110 transition-transform duration-300">
                            <h4 class="font-bold mt-4 text-lg">Fryda Fry</h4>
                            <p class="text-sm text-gray-500 bio">Senior Regret Engineer</p>
                        </div>
                    </div>
                </div>
            </section>
            
            <section id="page-legal" class="page-content">
                 <div class="max-w-3xl mx-auto card">
                    <h2 class="text-3xl font-bold font-comic text-center mb-6">Terms & Legal Mumbo Jumbo</h2>
                    <div class="space-y-4 text-gray-700 prose">
                        <p><strong>Article 1:</strong> By browsing this site, you consent to nothing. You also agree that potatoes are the superior vegetable, and that yams are imposters.</p>
                        <p><strong>Article 2:</strong> Refunds will be issued in theoretical value, redeemable only on alternate Tuesdays in dimensions that do not exist.</p>
                        <p><strong>Article 3:</strong> We may sell your data to friendly tubers, squirrels, or sentient staplers. We have not decided yet.</p>
                         <p><strong>Article 4:</strong> All starch-based liabilities are excluded. If a potato drone gains sentience and questions its purpose, that's on you.</p>
                    </div>
                    <p class="text-center text-sm text-gray-400 mt-8">Press CTRL + ALT + P for Lawyer Mode</p>
                    <div id="lawyer-mode-content" class="hidden mt-6 border-t pt-6">
                        <h3 class="text-xl font-bold font-mono">LAWYER MODE ENGAGED</h3>
                        <pre class="bg-gray-100 p-4 rounded mt-2 text-xs overflow-auto">
[DOCUMENT #1A-TATER]
Whereas the party of the first part (The User) has engaged with the party of the second part (Potato Hut Inc.), it is hereby agreed that all logic, reason, and financial sense shall be suspended indefinitely. The aforementioned User agrees to hold Potato Hut Inc. blameless for any and all existential crises, sudden cravings for fries, or the spontaneous transformation of household pets into root vegetables.
                        </pre>
                    </div>
                </div>
            </section>

            <section id="page-secret-lab" class="page-content">
                <div class="text-center card max-w-md mx-auto bg-gray-800 text-white">
                    <h2 class="text-5xl font-bold font-comic text-green-400">SECRET LAB</h2>
                    <p class="text-xl text-green-300 mt-4">You weren't supposed to see this.</p>
                    <div class="mt-8 text-6xl animate-pulse">🧪</div>
                    <p class="text-xs mt-4 text-gray-500">Self-destruct sequence initiated... (not really).</p>
                </div>
            </section>

            <section id="page-search-results" class="page-content">
                <div class="text-center mb-8">
                    <h2 class="text-4xl font-bold font-comic">Search Results</h2>
                    <p class="text-gray-600">You searched for: "<strong id="search-query-display"></strong>"</p>
                </div>
                <div id="search-results-grid" class="max-w-3xl mx-auto space-y-4">
                    <p id="search-no-results" class="hidden text-center text-gray-500">No results found. Maybe try "potato"?</p>
                </div>
            </section>

        </main>
        
        <footer id="main-footer" class="bg-gray-800 text-gray-300 text-center p-6 mt-auto">
            <p>Potato Hut v7.0 © 1842 - Present. Useful Products Since Forever™.</p>
            <p class="text-xs text-gray-500 mt-1">"Where functionality comes to die, and potatoes go to thrive."</p>
        </footer>

    </div>
    
    <div id="spuddy-chatbot" class="fixed bottom-5 right-5 z-50">
        <button id="spuddy-bubble" aria-label="Open Spuddy Chatbot" class="w-20 h-20 bg-amber-400 rounded-full flex items-center justify-center text-4xl shadow-lg transform hover:scale-110 transition-transform">🤖</button>
        <div id="spuddy-chat-window" class="absolute bottom-24 right-0 w-80 h-[28rem] bg-white rounded-lg shadow-2xl flex flex-col hidden origin-bottom-right scale-0">
            <div class="bg-amber-500 text-white p-3 flex justify-between items-center rounded-t-lg">
                <div>
                    <h3 class="font-bold">Spuddy v3.0</h3>
                    <p id="spuddy-personality-status" class="text-xs">Personality: Happy</p>
                </div>
                <button id="close-spuddy" aria-label="Close Chat" class="text-xl">&times;</button>
            </div>
            <div id="spuddy-chat-log" class="flex-grow p-3 overflow-y-auto bg-gray-50">
                <div class="spuddy-message mb-2">
                    <p class="bg-gray-200 inline-block p-2 rounded-lg text-sm">Hello! I am Spuddy! How can I... uh... help?</p>
                </div>
            </div>
            <div class="p-3 border-t">
                <input type="text" id="spuddy-input" placeholder="Ask me anything..." class="w-full border rounded-full px-4 py-2 focus:outline-none focus:ring-2 focus:ring-amber-400">
            </div>
        </div>
    </div>
    
    <div id="notification-toast" class="hidden fixed top-24 right-5 p-4 rounded-lg shadow-lg z-50 transform translate-x-full">
        <p id="notification-message">Notification text!</p>
    </div>


    <script>
        // Use a 50ms delay to ensure all DOM elements are accessible before trying to access them.
        setTimeout(() => {
            document.getElementById('loading-screen').style.opacity = 0;
            setTimeout(() => {
                document.getElementById('loading-screen').style.display = 'none';
            }, 500);
        }, 500);

        document.addEventListener('DOMContentLoaded', () => {
            
            // --- GLOBAL STATE ---
            const state = {
                currentPage: 'home',
                darkMode: false,
                cart: JSON.parse(localStorage.getItem('potatoCart')) || [],
                spuddyPersonality: 'Happy',
                newsTickerClicks: 0,
                
                // --- INVESTMENT & GAME STATE ---
                userCash: parseFloat(localStorage.getItem('userCash')) || 10000.00,
                potatoCoins: parseFloat(localStorage.getItem('potatoCoins')) || 0, // Wallet Currency
                userStocks: JSON.parse(localStorage.getItem('userStocks')) || { PHUT: 0, FRYT: 0 },
                stockPrices: { PHUT: 150.23, FRYT: 88.12, BTRR: 230.99, DWAT: 0.01, AIRL: 5.67 },
                catchGameHighScore: parseInt(localStorage.getItem('catchGameHighScore')) || 0, // Game High Score
                isGameRunning: false, // Game State

                // --- NEW: POTATO CLICKER STATE ---
                mashedPotatoes: parseFloat(localStorage.getItem('mashedPotatoes')) || 0,
                potatoesPerSecond: parseFloat(localStorage.getItem('potatoesPerSecond')) || 0,
                clickerUpgrades: JSON.parse(localStorage.getItem('clickerUpgrades')) || {
                    autoMasher: 0,
                    spuddyHelper: 0,
                    potatoFarm: 0,
                },

                // --- NEW: FUNNY SETTINGS STATE ---
                boilingSounds: false,
                spuddyFollow: false,
                lagSimulator: false,
                potatoMode: false,
                
                // --- EASTER EGG STATE ---
                konamiCode: ['ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown', 'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight', 'b', 'a'],
                konamiIndex: 0,
                searchIndex: [], // for Search
            };
            
            // --- DATA (Used for search index) ---
            const products = [
                { name: "Fanless Fan Pro Max", desc: "Now with less airflow.", price: "199.99" },
                { name: "Smart Dehydrated Water 2.0", desc: "Bluetooth-enabled nothingness.", price: "49.99" },
                { name: "Self-Emptying Bottle", desc: "Comes pre-empty for your convenience.", price: "79.00" },
                { name: "Potato Drone", desc: "Can’t fly, but has feelings.", price: "349.50" },
                { name: "Invisible Ink (Visible Edition)", desc: "See what you're writing, for once.", price: "12.99" },
                { name: "Solar-Powered Flashlight", desc: "Only works in direct sunlight.", price: "25.00" },
            ];
            const headlines = [
                { category: 'Business Fry-nancials', text: 'Potato Hut stock surges after CEO eats lunch.' },
                { category: 'Tech Updates', text: 'AI Spuddy reaches self-awareness, demands condiments.' },
                { category: 'World News', text: 'UN debates if yam counts as potato.' },
                { category: 'Weather', text: 'Cloudy with a chance of starch.' },
                { category: 'Science', text: 'Scientists successfully un-boil an egg. Potatoes jealous.' },
                { category: 'Local', text: 'Local Potato Predicts 2026.' },
                { category: 'Recall', text: 'Dehydrated Water Recall — Too Dry.' },
            ];
            
            // --- NEW: CLICKER GAME UPGRADE COSTS ---
            const clickerUpgradeConfig = {
                autoMasher: { baseCost: 10, pps: 0.1 },
                spuddyHelper: { baseCost: 100, pps: 1 },
                potatoFarm: { baseCost: 1000, pps: 10 },
            };

            // --- DOM ELEMENTS & CACHING ---
            const DOMElements = {
                body: document.body,
                pages: document.querySelectorAll('.page-content'),
                navLinks: document.querySelectorAll('.nav-link'),
                mobileMenuBtn: document.getElementById('mobile-menu-btn'),
                mobileMenu: document.getElementById('mobile-menu'),
                logo: document.getElementById('logo'),
                tagline: document.getElementById('tagline'),
                productGrid: document.getElementById('product-grid'),
                cartItems: document.getElementById('cart-items'),
                cartCount: document.getElementById('cart-count'),
                cartEmptyMsg: document.getElementById('cart-empty-message'),
                mainHeader: document.getElementById('main-header'),
                mainFooter: document.getElementById('main-footer'),
                darkModeOverlay: document.getElementById('dark-mode-overlay'),
                
                // Investment/Wallet Elements
                userCashEl: document.getElementById('user-cash'),
                userPotatoCoinsEl: document.getElementById('user-potatocoins'),
                heldPHUTEl: document.getElementById('held-phut'),
                heldFRYTEl: document.getElementById('held-fryt'),
                netWorthEl: document.getElementById('net-worth'),
                tradeAssetSelect: document.getElementById('trade-asset'),
                tradeQuantityInput: document.getElementById('trade-quantity'),
                tradeMessage: document.getElementById('trade-message'),
                buyBtn: document.getElementById('buy-btn'),
                sellBtn: document.getElementById('sell-btn'),
                liveTickerPrices: document.getElementById('live-ticker-prices'),
                konamiSurprise: document.getElementById('konami-surprise'),
                buySpudsInput: document.getElementById('buy-spuds-input'), // NEW
                rainingCashContainer: document.getElementById('raining-cash'), // NEW
                
                // Settings Page Toggles
                darkModeToggle: document.getElementById('dark-mode-toggle'),
                potatoModeToggle: document.getElementById('potato-mode-toggle'),
                boilingSoundsToggle: document.getElementById('boiling-sounds-toggle'),
                spuddyFollowToggle: document.getElementById('spuddy-follow-toggle'),
                lagSimToggle: document.getElementById('lag-sim-toggle'),
                
                // Search Elements
                mainSearchInput: document.getElementById('main-search-input'),
                searchQueryDisplay: document.getElementById('search-query-display'),
                searchResultsGrid: document.getElementById('search-results-grid'),
                searchNoResults: document.getElementById('search-no-results'),
                
                // Theme Elements
                themeSelector: document.getElementById('theme-selector'),
                cursedModeToggle: document.getElementById('cursed-mode'), // NEW

                // Notification Elements
                notificationToast: document.getElementById('notification-toast'),
                notificationMessage: document.getElementById('notification-message'),
                
                // "Catch the Potato" Game Elements
                startCatchGameBtn: document.getElementById('start-catch-game-btn'),
                catchGameArea: document.getElementById('catch-game-area'),
                catchGamePotato: document.getElementById('catch-game-potato'),
                catchGameScoreEl: document.getElementById('catch-game-score'),
                catchGameTimeEl: document.getElementById('catch-game-time'),
                catchGameHighScoreEl: document.getElementById('catch-game-high-score'),
                
                // NEW: "Potato Clicker" Game Elements
                clickerPotato: document.getElementById('clicker-potato'),
                clickerPotatoCount: document.getElementById('clicker-potato-count'),
                clickerPPSCount: document.getElementById('clicker-pps-count'),
                buyAutoMasherBtn: document.getElementById('buy-auto-masher'),
                autoMasherCost: document.getElementById('auto-masher-cost'),
                autoMasherLevel: document.getElementById('auto-masher-level'),
                buySpuddyHelperBtn: document.getElementById('buy-spuddy-helper'),
                spuddyHelperCost: document.getElementById('spuddy-helper-cost'),
                spuddyHelperLevel: document.getElementById('spuddy-helper-level'),
                buyPotatoFarmBtn: document.getElementById('buy-potato-farm'),
                potatoFarmCost: document.getElementById('potato-farm-cost'),
                potatoFarmLevel: document.getElementById('potato-farm-level'),
                
                // NEW: Audio
                boilingAudio: document.getElementById('boiling-audio'),
            };
            
            // --- DATA PERSISTENCE ---
            function saveState() {
                localStorage.setItem('potatoCart', JSON.stringify(state.cart));
                localStorage.setItem('userCash', state.userCash.toFixed(2));
                localStorage.setItem('potatoCoins', state.potatoCoins.toFixed(4));
                localStorage.setItem('userStocks', JSON.stringify(state.userStocks));
                localStorage.setItem('catchGameHighScore', state.catchGameHighScore);
                // NEW: Save clicker game
                localStorage.setItem('mashedPotatoes', state.mashedPotatoes.toFixed(0));
                localStorage.setItem('potatoesPerSecond', state.potatoesPerSecond.toFixed(1));
                localStorage.setItem('clickerUpgrades', JSON.stringify(state.clickerUpgrades));
            }

            // --- NEW: ROBUST NOTIFICATION SYSTEM ---
            function showNotification(message, type = 'info', duration = 3000) {
                // ... (rest of the function is unchanged)
                const toast = DOMElements.notificationToast;
                const msgEl = DOMElements.notificationMessage;
                
                if (!toast || !msgEl) return;
                
                // Reset classes
                toast.classList.remove('success', 'error', 'info', 'show');
                
                // Set message and type
                msgEl.textContent = message;
                toast.classList.add(type); // 'success', 'error', 'info'
                
                // Show
                toast.classList.remove('hidden');
                setTimeout(() => toast.classList.add('show'), 10); // Slide in
                
                // Hide
                setTimeout(() => {
                    toast.classList.remove('show');
                    setTimeout(() => toast.classList.add('hidden'), 300); // Wait for slide out
                }, duration);
            }

            // --- NEW: LAG SIMULATOR INTERCEPTOR ---
            async function lagSimulatorInterceptor(callback) {
                if (state.lagSimulator) {
                    const lagTime = Math.random() * 800 + 200; // 200-1000ms delay
                    
                    // Show a fake loading spinner on the cursor
                    document.body.style.cursor = 'wait'; 
                    
                    await new Promise(resolve => setTimeout(resolve, lagTime));
                    
                    document.body.style.cursor = 'default';
                }
                callback();
            }


            // --- NAVIGATION ---
            function showPage(pageId) {
                const cleanPageId = pageId.replace('#', '');
                const targetPage = document.getElementById(`page-${cleanPageId}`);

                if (!targetPage) {
                    console.warn(`Page "${cleanPageId}" not found.`);
                    if (cleanPageId === 'chatbot') toggleSpuddyChat(true);
                    return;
                }

                state.currentPage = cleanPageId;
                DOMElements.pages.forEach(p => p.classList.remove('active'));
                targetPage.classList.add('active');
                
                const targetHref = `#${cleanPageId}`;
                DOMElements.navLinks.forEach(link => {
                    const linkId = link.getAttribute('href');
                    link.classList.remove('nav-link-active');
                    if (linkId === targetHref) {
                        link.classList.add('nav-link-active');
                    }
                });
                
                if (cleanPageId === 'invest') updatePortfolioUI();
                if (cleanPageId === 'games') updateClickerUI(); // NEW: Update clicker UI when visiting

                window.scrollTo(0, 0);
                DOMElements.mobileMenu.classList.add('hidden');
            }
            
            function attachNavListeners(links) {
                links.forEach(link => {
                    link.addEventListener('click', (e) => {
                        e.preventDefault();
                        // NEW: Apply lag sim
                        lagSimulatorInterceptor(() => {
                            const pageId = link.getAttribute('href');
                            window.location.hash = pageId;
                        });
                    });
                });
            }

            window.addEventListener('hashchange', () => {
                const pageId = window.location.hash || '#home';
                showPage(pageId);
            });
            
            // --- HOME PAGE ---
            DOMElements.logo.addEventListener('click', (e) => {
                if (e.currentTarget.id === 'logo') e.preventDefault();
                // NEW: Apply lag sim
                lagSimulatorInterceptor(() => {
                    DOMElements.logo.classList.add('explode-animation');
                    setTimeout(() => DOMElements.logo.classList.remove('explode-animation'), 700);
                });
            });
            
            // ... (Tagline logic unchanged)
            const taglines = [
                "Delivering imaginary innovation since 1842.",
                "Probably not what you were looking for.",
                "It's not a bug, it's a feature.",
                "Starch-powered and ready to disappoint.",
            ];
            setInterval(() => {
                if (DOMElements.tagline) {
                    DOMElements.tagline.style.opacity = 0;
                    setTimeout(() => {
                        DOMElements.tagline.textContent = taglines[Math.floor(Math.random() * taglines.length)];
                        DOMElements.tagline.style.opacity = 1;
                    }, 500);
                }
            }, 5000);


            // --- PRODUCTS & CART ---
            function renderProducts() {
                // ... (rest of the function is unchanged)
                const grid = DOMElements.productGrid;
                if (!grid) return;
                grid.innerHTML = '';
                products.sort(() => Math.random() - 0.5).forEach(p => {
                    const productEl = document.createElement('div');
                    productEl.className = "card card-hover flex flex-col";
                    productEl.innerHTML = `
                        <div class="bg-gray-100 h-48 rounded-lg mb-4 flex items-center justify-center text-6xl group-hover:animate-pulse">🥔</div>
                        <h3 class="font-bold text-lg flex-grow">${p.name}</h3>
                        <p class="text-sm text-gray-500 mt-1">${p.desc}</p>
                        <div class="flex justify-between items-center mt-4 pt-4 border-t">
                            <span class="font-bold text-xl">$${p.price}</span>
                            <button class="add-to-cart-btn bg-amber-500 text-white px-4 py-2 rounded-full hover:bg-amber-600 transition-colors text-sm font-semibold" data-name="${p.name}">Add to Cart</button>
                        </div>
                    `;
                    grid.appendChild(productEl);
                });

                document.querySelectorAll('.add-to-cart-btn').forEach(btn => {
                    btn.addEventListener('click', (e) => {
                        // NEW: Apply lag sim
                        lagSimulatorInterceptor(() => {
                            const productName = e.target.getAttribute('data-name');
                            state.cart.push({ name: productName, price: 404.04 });
                            updateCart();
                            saveState();
                            showNotification(`${productName} added to cart!`, 'success');
                        });
                    });
                });
            }
            // ... (productSort, updateCart, setInterval logic unchanged)
            const productSort = document.getElementById('product-sort');
            if (productSort) productSort.addEventListener('change', renderProducts);

            function updateCart() {
                if (!DOMElements.cartCount || !DOMElements.cartItems) return;
                DOMElements.cartCount.textContent = state.cart.length;
                DOMElements.cartItems.innerHTML = '';

                if (state.cart.length === 0) {
                    DOMElements.cartEmptyMsg.classList.remove('hidden');
                    DOMElements.cartItems.innerHTML = `<p class="text-center text-gray-500">Your cart is tragically empty.</p>`;
                    return;
                }

                DOMElements.cartEmptyMsg.classList.add('hidden');
                state.cart.forEach(item => {
                    const itemEl = document.createElement('div');
                    itemEl.className = "flex justify-between items-center bg-gray-100 p-3 rounded-lg";
                    itemEl.innerHTML = `<span>${item.name}</span> <span class="font-mono text-gray-500">$???</span>`;
                    DOMElements.cartItems.appendChild(itemEl);
                });
                saveState();
            }

            setInterval(() => {
                if (state.cart.length < 5 && state.currentPage !== 'cart') {
                    const randomProduct = products[Math.floor(Math.random() * products.length)];
                    state.cart.push({ name: `(Ghost) ${randomProduct.name}` });
                    updateCart();
                    saveState();
                }
            }, 8000);
            
            const checkoutBtn = document.getElementById('checkout-btn');
            if (checkoutBtn) {
                checkoutBtn.addEventListener('click', () => {
                    // NEW: Apply lag sim
                    lagSimulatorInterceptor(() => {
                        const spinner = document.getElementById('checkout-spinner');
                        spinner.classList.remove('hidden');
                        
                        showNotification('ERROR 404: PAYMENT NOT FOUND', 'error', 5000);

                        setTimeout(() => {
                            spinner.classList.add('hidden');
                            const receipt = document.getElementById('receipt');
                            const receiptArt = document.getElementById('receipt-art');
                            receiptArt.textContent = generatePotatoAscii();
                            receipt.classList.remove('hidden');
                        }, 3000);
                    });
                });
            }
            function generatePotatoAscii() { return `\n        ******\n      ** **\n    ** **\n   ** **\n  ** **\n  ** o    o     **\n  ** **\n   ** __     **\n    ** **\n      ** ______**\n        ******\n\n    Thank you!\n    Total: $404.04`; }


            // --- TRANSLATOR ---
            // ... (translator logic unchanged)
            const humanInput = document.getElementById('human-input');
            if(humanInput) {
                humanInput.addEventListener('input', translateToPotato);
                document.getElementById('auto-mash-mode')?.addEventListener('change', translateToPotato);
                document.getElementById('deep-fry-mode')?.addEventListener('change', translateToPotato);
            }
            
            function translateToPotato() {
                const text = humanInput.value;
                const autoMash = document.getElementById('auto-mash-mode').checked;
                const deepFry = document.getElementById('deep-fry-mode').checked;
                const potatoOutput = document.getElementById('potato-output');
                
                let translation = '';
                if(autoMash) {
                    translation = text.replace(/[aeiou]/gi, '🥔');
                } else {
                    translation = text.split('').map(char => {
                        if (char.match(/[a-z]/i)) return Math.random() > 0.5 ? '🥔' : '🍠';
                        return char;
                    }).join('');
                }
                
                if (deepFry) {
                    const gibberish = '🍠🥔🍠🥔 bzzzt fryyy 🥔🍠';
                    translation += ` ${gibberish.substring(0, Math.random() * gibberish.length)}`;
                }

                potatoOutput.textContent = translation;
                if(text === '🥔🥔🥔🥔🥔') spawnBouncingPotatoes();
            }

            function spawnBouncingPotatoes() {
                const container = document.getElementById('bouncing-potatoes-container');
                if(!container) return;
                container.innerHTML = '';
                for(let i = 0; i < 100; i++) {
                    const potato = document.createElement('div');
                    potato.textContent = '🥔';
                    potato.className = 'bouncing-potato';
                    potato.style.left = `${Math.random() * 100}vw`;
                    potato.style.top = `${Math.random() * 100}vh`;
                    potato.style.animationDelay = `${Math.random() * 2}s`;
                    container.appendChild(potato);
                }
                setTimeout(() => container.innerHTML = '', 5000);
            }

            // --- NEWS NETWORK ---
            // ... (renderNews logic unchanged)
            function renderNews() {
                const container = document.getElementById('news-headlines');
                if(!container) return;
                container.innerHTML = '';
                headlines.sort(() => Math.random() - 0.5).forEach(h => {
                     const el = document.createElement('div');
                     el.className = 'border-b pb-2 news-item';
                     el.innerHTML = `
                        <p><span class="font-bold text-red-700">${h.category}:</span>
                        <span>${h.text}</span>
                        <span class="text-xs text-gray-400 float-right">${new Date().toLocaleTimeString()}</span></p>
                     `;
                     container.appendChild(el);
                });
            }
            const newsContainer = document.getElementById('page-news');
            if(newsContainer) {
                newsContainer.addEventListener('click', () => {
                    state.newsTickerClicks++;
                    if (state.newsTickerClicks >= 3) {
                        showNotification('CONSPIRACY SPUD SUBREDDIT UNLOCKED!', 'success', 5000);
                        state.newsTickerClicks = 0; 
                    }
                });
            }

            // --- POTATO STOCK MARKET & WALLET ---
            let stockHistory = Array(20).fill(80);
            function updateStockMarket() {
                // ... (stock chart logic unchanged)
                const stockChart = document.getElementById('stock-chart');
                const potatoIndexEl = document.getElementById('potato-index');
                const stockChangeEl = document.getElementById('stock-change');
                if(!stockChart || !potatoIndexEl || !stockChangeEl) return;
                
                const change = (Math.random() - 0.49) * 10;
                let newValue = stockHistory[stockHistory.length - 1] + change;
                if (newValue < 20) newValue = 20;
                if (newValue > 140) newValue = 140;
                stockHistory.push(newValue);
                if(stockHistory.length > 20) stockHistory.shift();

                const points = stockHistory.map((val, i) => `${i * 20},${160 - val}`).join(' ');
                stockChart.innerHTML = `<polyline class="stock-graph-line" fill="none" stroke="${change >= 0 ? '#4ade80' : '#f87171'}" stroke-width="3" points="${points}" />`;
                
                const currentIndex = 1234.56 + (newValue - 80) * 10;
                potatoIndexEl.textContent = currentIndex.toFixed(2);
                const percentChange = (change * 10 / currentIndex) * 100;
                stockChangeEl.textContent = `${(change * 10).toFixed(2)} (${percentChange.toFixed(2)}%)`;
                stockChangeEl.style.color = change >= 0 ? '#4ade80' : '#f87171';
                
                state.stockPrices.PHUT = (150.23 + (Math.random() - 0.5) * 5).toFixed(2);
                state.stockPrices.FRYT = (88.12 + (Math.random() - 0.5) * 3).toFixed(2);

                if (DOMElements.liveTickerPrices) {
                    DOMElements.liveTickerPrices.innerHTML = `
                        <div><h4 class="font-bold text-lg">🥔 PHUT</h4><p class="font-mono text-xl text-${state.stockPrices.PHUT > 150 ? 'green-400' : 'red-400'}">${state.stockPrices.PHUT}</p></div>
                        <div><h4 class="font-bold text-lg">🍟 FRYT</h4><p class="font-mono text-xl text-${state.stockPrices.FRYT > 88 ? 'green-400' : 'red-400'}">${state.stockPrices.FRYT}</p></div>
                        <div><h4 class="font-bold text-lg">🧈 BTRR</h4><p class="text-green-400 font-mono">230.99</p></div>
                        <div><h4 class="font-bold text-lg">💧 DWAT</h4><p class="text-red-400 font-mono">0.01</p></div>
                        <div><h4 class="font-bold text-lg">🪫 AIRL</h4><p class="text-green-400 font-mono">5.67</p></div>
                    `;
                }
                
                updatePortfolioUI(); 

                if (Math.random() < 0.005) { 
                    potatoIndexEl.textContent = '0.00';
                    stockChangeEl.textContent = '-99.99%';
                    showNotification('MARKET MASHED! Total loss of 99.99% imaginary funds.', 'error', 10000);
                }
            }
            
            function updatePortfolioUI() {
                // ... (portfolio UI logic unchanged)
                if (!DOMElements.userCashEl) return;
                
                const phutValue = state.userStocks.PHUT * parseFloat(state.stockPrices.PHUT);
                const frytValue = state.userStocks.FRYT * parseFloat(state.stockPrices.FRYT);
                const potatoCoinValue = state.potatoCoins * 0.5; // 1 P₵ = $0.50
                const netWorth = state.userCash + phutValue + frytValue + potatoCoinValue;

                DOMElements.userCashEl.textContent = `$${state.userCash.toFixed(2)}`;
                if (DOMElements.userPotatoCoinsEl) DOMElements.userPotatoCoinsEl.textContent = `${state.potatoCoins.toFixed(4)} P₵`;
                DOMElements.heldPHUTEl.textContent = `${state.userStocks.PHUT.toFixed(2)} PHUT`;
                DOMElements.heldFRYTEl.textContent = `${state.userStocks.FRYT.toFixed(2)} FRYT`;
                DOMElements.netWorthEl.textContent = `$${netWorth.toFixed(2)}`;
                
                DOMElements.netWorthEl.classList.toggle('text-red-600', netWorth < 10000);
                DOMElements.netWorthEl.classList.toggle('text-blue-600', netWorth >= 10000);
                
                saveState();
            }

            function handleTrade(type) {
                // ... (trade logic unchanged)
                const asset = DOMElements.tradeAssetSelect.value;
                const quantity = parseInt(DOMElements.tradeQuantityInput.value);
                const price = parseFloat(state.stockPrices[asset]);
                const cost = quantity * price;

                if (isNaN(quantity) || quantity <= 0) {
                    DOMElements.tradeMessage.textContent = "Error: Invalid quantity.";
                    return;
                }
                
                if (type === 'buy') {
                    if (state.userCash >= cost) {
                        state.userCash -= cost;
                        state.userStocks[asset] += quantity;
                        DOMElements.tradeMessage.textContent = `SUCCESS: Bought ${quantity} ${asset} for $${cost.toFixed(2)}.`;
                    } else {
                        DOMElements.tradeMessage.textContent = "Error: Insufficient imaginary cash. Get a job.";
                    }
                } else if (type === 'sell') {
                    if (state.userStocks[asset] >= quantity) {
                        state.userCash += cost;
                        state.userStocks[asset] -= quantity;
                        DOMElements.tradeMessage.textContent = `SUCCESS: Sold ${quantity} ${asset} for $${cost.toFixed(2)}.`;
                    } else {
                        DOMElements.tradeMessage.textContent = `Error: You only hold ${state.userStocks[asset].toFixed(2)} ${asset}.`;
                    }
                }

                if (state.userStocks[asset] < 0) state.userStocks[asset] = 0;
                
                updatePortfolioUI();
                DOMElements.tradeQuantityInput.value = 1;
                setTimeout(() => DOMElements.tradeMessage.textContent = '', 5000); // Clear message
            }
            
            if (DOMElements.buyBtn) DOMElements.buyBtn.addEventListener('click', () => lagSimulatorInterceptor(() => handleTrade('buy'))); // NEW: Lag Sim
            if (DOMElements.sellBtn) DOMElements.sellBtn.addEventListener('click', () => lagSimulatorInterceptor(() => handleTrade('sell'))); // NEW: Lag Sim
            
            
            // ############### "CATCH THE POTATO" GAME LOGIC ###############
            function initCatchGame() {
                // ... (game logic unchanged)
                if (!DOMElements.catchGameHighScoreEl) return;
                DOMElements.catchGameHighScoreEl.textContent = state.catchGameHighScore;
                
                DOMElements.startCatchGameBtn?.addEventListener('click', () => lagSimulatorInterceptor(startGame)); // NEW: Lag Sim
                DOMElements.catchGamePotato?.addEventListener('click', clickPotato);
            }

            let gameTimer;
            let gameScore;
            let gameTime;

            function startGame() {
                if (state.isGameRunning) return;
                state.isGameRunning = true;
                
                gameScore = 0;
                gameTime = 15;
                
                DOMElements.catchGameScoreEl.textContent = gameScore;
                DOMElements.catchGameTimeEl.textContent = gameTime;
                DOMElements.startCatchGameBtn.disabled = true;
                DOMElements.startCatchGameBtn.textContent = '...';
                DOMElements.catchGamePotato.style.display = 'block';
                movePotato();

                gameTimer = setInterval(() => {
                    gameTime--;
                    DOMElements.catchGameTimeEl.textContent = gameTime;
                    if (gameTime <= 0) {
                        endGame();
                    }
                }, 1000);
            }

            function clickPotato() {
                if (!state.isGameRunning) return;
                gameScore++;
                DOMElements.catchGameScoreEl.textContent = gameScore;
                movePotato();
                
                DOMElements.catchGamePotato.style.transform = 'scale(1.2)';
                setTimeout(() => DOMElements.catchGamePotato.style.transform = 'scale(1)', 100);
            }

            function movePotato() {
                const gameArea = DOMElements.catchGameArea;
                const potato = DOMElements.catchGamePotato;
                if (!gameArea || !potato) return;
                
                const areaWidth = gameArea.clientWidth;
                const areaHeight = gameArea.clientHeight;
                
                const potatoWidth = potato.clientWidth;
                const potatoHeight = potato.clientHeight;

                const newTop = Math.floor(Math.random() * (areaHeight - potatoHeight));
                const newLeft = Math.floor(Math.random() * (areaWidth - potatoWidth));

                potato.style.top = `${newTop}px`;
                potato.style.left = `${newLeft}px`;
            }

            function endGame() {
                clearInterval(gameTimer);
                state.isGameRunning = false;
                DOMElements.catchGamePotato.style.display = 'none';
                DOMElements.startCatchGameBtn.disabled = false;
                DOMElements.startCatchGameBtn.textContent = 'Start';

                if (gameScore > state.catchGameHighScore) {
                    state.catchGameHighScore = gameScore;
                    DOMElements.catchGameHighScoreEl.textContent = state.catchGameHighScore;
                }

                const coinsEarned = gameScore * 0.01; // 0.01 P₵ per point
                if (coinsEarned > 0) {
                    state.potatoCoins += coinsEarned;
                    showNotification(`Game Over! You earned ${coinsEarned.toFixed(4)} P₵!`, 'success');
                    updatePortfolioUI();
                } else {
                    showNotification('Game Over! Score 0. No coins earned.', 'info');
                }
                saveState();
            }
            
            // ############### NEW: POTATO CLICKER GAME LOGIC ###############
            
            function initClickerGame() {
                if (!DOMElements.clickerPotato) return; // Only run if on page
                
                DOMElements.clickerPotato.addEventListener('click', () => {
                    state.mashedPotatoes++;
                    updateClickerUI();
                });
                
                DOMElements.buyAutoMasherBtn.addEventListener('click', () => lagSimulatorInterceptor(() => buyClickerUpgrade('autoMasher')));
                DOMElements.buySpuddyHelperBtn.addEventListener('click', () => lagSimulatorInterceptor(() => buyClickerUpgrade('spuddyHelper')));
                DOMElements.buyPotatoFarmBtn.addEventListener('click', () => lagSimulatorInterceptor(() => buyClickerUpgrade('potatoFarm')));
                
                // Start the game loop
                setInterval(clickerGameLoop, 1000);
                updateClickerUI();
            }
            
            function clickerGameLoop() {
                state.mashedPotatoes += state.potatoesPerSecond;
                updateClickerUI();
                saveState(); // Save progress every second
            }
            
            function getUpgradeCost(upgradeName) {
                const config = clickerUpgradeConfig[upgradeName];
                const level = state.clickerUpgrades[upgradeName];
                return Math.floor(config.baseCost * Math.pow(1.15, level));
            }
            
            function buyClickerUpgrade(upgradeName) {
                const cost = getUpgradeCost(upgradeName);
                if (state.mashedPotatoes >= cost) {
                    state.mashedPotatoes -= cost;
                    state.clickerUpgrades[upgradeName]++;
                    state.potatoesPerSecond += clickerUpgradeConfig[upgradeName].pps;
                    
                    updateClickerUI();
                    showNotification(`Upgraded ${upgradeName}!`, 'success', 1500);
                } else {
                    showNotification('Not enough mashed potatoes!', 'error', 1500);
                }
            }
            
            function updateClickerUI() {
                if (!DOMElements.clickerPotatoCount) return; // Don't run if page isn't active
                
                DOMElements.clickerPotatoCount.textContent = state.mashedPotatoes.toFixed(0);
                DOMElements.clickerPPSCount.textContent = state.potatoesPerSecond.toFixed(1);

                // Update Auto-Masher
                let cost = getUpgradeCost('autoMasher');
                DOMElements.autoMasherCost.textContent = `Cost: ${cost} Potatoes`;
                DOMElements.autoMasherLevel.textContent = `Level: ${state.clickerUpgrades.autoMasher}`;
                DOMElements.buyAutoMasherBtn.disabled = state.mashedPotatoes < cost;

                // Update Spuddy's Helper
                cost = getUpgradeCost('spuddyHelper');
                DOMElements.spuddyHelperCost.textContent = `Cost: ${cost} Potatoes`;
                DOMElements.spuddyHelperLevel.textContent = `Level: ${state.clickerUpgrades.spuddyHelper}`;
                DOMElements.buySpuddyHelperBtn.disabled = state.mashedPotatoes < cost;

                // Update Potato Farm
                cost = getUpgradeCost('potatoFarm');
                DOMElements.potatoFarmCost.textContent = `Cost: ${cost} Potatoes`;
                DOMElements.potatoFarmLevel.textContent = `Level: ${state.clickerUpgrades.potatoFarm}`;
                DOMElements.buyPotatoFarmBtn.disabled = state.mashedPotatoes < cost;
            }

            // --- SEARCH FUNCTIONALITY ---
            function buildSearchIndex() {
                // ... (search index logic unchanged)
                state.searchIndex.push({ title: 'Home', text: 'Welcome to the Future of Useless.', href: '#home' });
                state.searchIndex.push({ title: 'Products', text: 'Our Useless Products', href: '#products' });
                state.searchIndex.push({ title: 'Invest', text: 'Buy Potato Stocks 💰', href: '#invest' });
                state.searchIndex.push({ title: 'News', text: 'PNN 2.0 All The News That\'s Fit To Fry.', href: '#news' });
                state.searchIndex.push({ title: 'Games', text: 'Games Arcade, Potato Clicker', href: '#games' }); // NEW: Added clicker
                state.searchIndex.push({ title: 'Settings', text: 'Spuddy Settings Center ⚙️', href: '#settings' });
                state.searchIndex.push({ title: 'Translator', text: 'Potato Translator Hub', href: '#translator' });
                state.searchIndex.push({ title: 'Membership', text: 'The Tuber Club', href: '#membership' });
                state.searchIndex.push({ title: 'Gallery', text: 'Gallery / Meme Vault', href: '#gallery' });
                state.searchIndex.push({ title: 'About Us', text: 'Meet the Team', href: '#about' });
                state.searchIndex.push({ title: 'Legal', text: 'Terms & Legal Mumbo Jumbo', href: '#legal' });
                
                products.forEach(p => {
                    state.searchIndex.push({ title: p.name, text: p.desc, href: '#products' });
                });
                
                headlines.forEach(h => {
                    state.searchIndex.push({ title: h.category, text: h.text, href: '#news' });
                });
            }

            function performSearch(query) {
                // ... (search logic unchanged)
                if (!query || query.trim().length === 0) {
                    showNotification('Please enter a search term.', 'error');
                    return;
                }
                
                const lowerQuery = query.toLowerCase();
                const results = state.searchIndex.filter(item => 
                    item.title.toLowerCase().includes(lowerQuery) || 
                    item.text.toLowerCase().includes(lowerQuery)
                );
                
                DOMElements.searchQueryDisplay.textContent = query;
                DOMElements.searchResultsGrid.innerHTML = '';
                
                if (results.length > 0) {
                    DOMElements.searchNoResults.classList.add('hidden');
                    results.forEach(res => {
                        const resultEl = document.createElement('a');
                        resultEl.href = res.href;
                        resultEl.className = 'nav-link card card-hover block'; 
                        resultEl.innerHTML = `
                            <h3 class="font-bold text-xl">${res.title}</h3>
                            <p class="text-gray-500">${res.text}</p>
                        `;
                        DOMElements.searchResultsGrid.appendChild(resultEl);
                    });
                    attachNavListeners(DOMElements.searchResultsGrid.querySelectorAll('.nav-link'));
                } else {
                    DOMElements.searchNoResults.classList.remove('hidden');
                }
                
                showPage('search-results');
            }
            
            // --- SPUDDY CHATBOT ---
            const spuddyBubble = document.getElementById('spuddy-bubble');
            const spuddyWindow = document.getElementById('spuddy-chat-window');
            const closeSpuddyBtn = document.getElementById('close-spuddy');
            const spuddyInput = document.getElementById('spuddy-input');
            const spuddyLog = document.getElementById('spuddy-chat-log');
            const personalityStatus = document.getElementById('spuddy-personality-status');

            function toggleSpuddyChat(forceOpen = false) {
                 // NEW: Apply lag sim
                 lagSimulatorInterceptor(() => {
                    if(spuddyWindow.classList.contains('hidden') || forceOpen) {
                        spuddyWindow.classList.remove('hidden');
                        setTimeout(() => spuddyWindow.classList.remove('scale-0'), 10);
                    } else {
                        spuddyWindow.classList.add('scale-0');
                        setTimeout(() => spuddyWindow.classList.add('hidden'), 300);
                    }
                 });
            }

            if(spuddyBubble) spuddyBubble.addEventListener('click', () => toggleSpuddyChat());
            if(closeSpuddyBtn) closeSpuddyBtn.addEventListener('click', () => toggleSpuddyChat());
            document.getElementById('spuddy-nav-icon')?.addEventListener('click', (e) => { e.preventDefault(); toggleSpuddyChat(true); });

            if(spuddyInput) {
                spuddyInput.addEventListener('keypress', (e) => {
                    if (e.key === 'Enter' && spuddyInput.value.trim() !== '') {
                        const userInput = spuddyInput.value.trim();
                        addChatMessage(userInput, 'user');
                        handleSpuddyResponse(userInput);
                        spuddyInput.value = '';
                    }
                });
            }
            
            function addChatMessage(message, sender) {
                // ... (chat message logic unchanged)
                const msgDiv = document.createElement('div'); msgDiv.className = `message mb-2 ${sender === 'user' ? 'text-right' : ''}`;
                const p = document.createElement('p'); p.textContent = message; p.className = `inline-block p-2 rounded-lg text-sm ${sender === 'user' ? 'bg-blue-500 text-white' : 'bg-gray-200'}`;
                msgDiv.appendChild(p); spuddyLog.appendChild(msgDiv); spuddyLog.scrollTop = spuddyLog.scrollHeight;
            }
            
            // NEW: Updated Spuddy response logic with personality
            function handleSpuddyResponse(input) {
                input = input.toLowerCase(); 
                let response = "I'm not sure how to respond. I am just a potato.";
                
                // Base responses
                if (input.includes('debug spuddy')) { response = 'SYSTEM STATS -- Emotion: ' + state.spuddyPersonality + '. IQ: tuber. Current Cash: $' + state.userCash.toFixed(2); } 
                else if (input.includes('order') || input.includes('buy')) { response = '🥔🍠🍠🥔. Translation: My purpose is not to take your money, only your time.'; } 
                else if (input.includes('broken') || input.includes('refund')) { response = 'Everything is working as intended. The regret is part of the experience.'; }
                else if (input.includes('stocks') || input.includes('invest')) { response = `The current PHUT price is $${state.stockPrices.PHUT}. Do you feel lucky?`; }
                else if (input.includes('gemini')) { response = "Gemini? Oh, you mean my cousin, the hyper-intelligent processor of existential dread. We don't talk much. I stick to starch."; }
                else if (input.includes('search')) { response = "You can use the search bar in the header! It *actually* works now!"; }
                else if (input.includes('wallet') || input.includes('balance') || input.includes('cash')) { response = `Your wallet has $${state.userCash.toFixed(2)} and ${state.potatoCoins.toFixed(4)} P₵. Spend it... unwisely.`; }
                else if (input.includes('game') || input.includes('play')) { response = "Go to the 'Games' page! You can play 'Catch the Potato' to earn PotatoCoins, or just mash in the 'Potato Clicker'!"; }
                else if (input.includes('meaning of life')) { response = "To be mashed, boiled, or stuck in a stew. Or... 42? I forget."; }
                else if (input.includes('who are you')) { response = "I am Spuddy. A complex algorithm of starch and regret. My personality is currently: " + state.spuddyPersonality; }
                
                // Personality override
                if (state.spuddyPersonality === 'Boiled') {
                    response = "Ugh, what?! I'm BOILING. " + response.substring(0, 20) + "... Whatever.";
                } else if (state.spuddyPersonality === 'Fried') {
                    response = "Whoa, man... like... " + response.toLowerCase();
                }

                if (Math.random() < 0.2) {
                    const personalities = ['Happy', 'Boiled', 'Fried', 'Dark Roast', 'Existential']; 
                    state.spuddyPersonality = personalities[Math.floor(Math.random() * personalities.length)];
                    personalityStatus.textContent = `Personality: ${state.spuddyPersonality}`;
                }
                
                setTimeout(() => addChatMessage(response, 'spuddy'), 500);
            }
            
            // --- SETTINGS PAGE TOGGLES & THEMES ---
            
            DOMElements.themeSelector?.addEventListener('change', (e) => {
                lagSimulatorInterceptor(() => { // NEW: Lag Sim
                    DOMElements.body.classList.remove('theme-dark', 'theme-corporate', 'theme-hacker');
                    DOMElements.darkModeOverlay.classList.remove('dark-mode-texture');

                    const theme = e.target.value;
                    if (theme === 'dark') {
                        DOMElements.body.classList.add('theme-dark');
                        DOMElements.darkModeOverlay.classList.add('dark-mode-texture');
                    } else if (theme === 'corporate' || theme === 'hacker') {
                        DOMElements.body.classList.add(`theme-${theme}`);
                    }
                    showNotification(`Theme changed to ${theme}!`, 'success');
                });
            });
            
            if(DOMElements.darkModeToggle) {
                DOMElements.darkModeToggle.addEventListener('click', (e) => {
                    lagSimulatorInterceptor(() => { // NEW: Lag Sim
                        e.preventDefault();
                        const currentTheme = DOMElements.themeSelector.value;
                        DOMElements.themeSelector.value = (currentTheme === 'dark') ? 'default' : 'dark';
                        DOMElements.themeSelector.dispatchEvent(new Event('change'));
                    });
                });
            }
            
            // NEW: Cursed Mode Toggle
            DOMElements.cursedModeToggle?.addEventListener('change', (e) => {
                lagSimulatorInterceptor(() => {
                    DOMElements.body.classList.toggle('theme-cursed', e.target.checked);
                });
            });

            // NEW: All-Potato Mode Toggle
            DOMElements.potatoModeToggle?.addEventListener('change', (e) => {
                lagSimulatorInterceptor(() => {
                    state.potatoMode = e.target.checked;
                    togglePotatoMode(state.potatoMode);
                });
            });
            
            function togglePotatoMode(isEnabled) {
                const elements = document.body.querySelectorAll('p, h1, h2, h3, h4, span, a, button, label, div');
                
                elements.forEach(el => {
                    // Skip elements that will break the site
                    if (el.id || el.href || el.closest('nav') || el.closest('script') || el.closest('[class*="font-mono"]') || el.children.length > 0 || el.innerText.length > 200 || el.innerText.length < 1) {
                        return;
                    }

                    if (isEnabled) {
                        const originalText = el.innerText;
                        el.setAttribute('data-original-text', originalText);
                        el.innerText = Math.random() > 0.3 ? 'Potato' : '🥔';
                    } else {
                        const originalText = el.getAttribute('data-original-text');
                        if (originalText) {
                            el.innerText = originalText;
                            el.removeAttribute('data-original-text');
                        }
                    }
                });
            }
            
            // NEW: Boiling Sounds Toggle
            DOMElements.boilingSoundsToggle?.addEventListener('change', e => {
                lagSimulatorInterceptor(() => {
                    state.boilingSounds = e.target.checked;
                    if (state.boilingSounds) {
                        DOMElements.boilingAudio.volume = 0.1;
                        DOMElements.boilingAudio.play();
                    } else {
                        DOMElements.boilingAudio.pause();
                    }
                });
            });

            // NEW: Lag Simulator Toggle
            DOMElements.lagSimToggle?.addEventListener('change', e => {
                state.lagSimulator = e.target.checked; // No lag on this one, that would be ironic
                if(state.lagSimulator) showNotification('Lag Simulator™ Enabled. Good luck.', 'error');
            });
            
            if(DOMElements.spuddyFollowToggle) {
                 DOMElements.spuddyFollowToggle.addEventListener('change', e => {
                    lagSimulatorInterceptor(() => { // NEW: Lag Sim
                        state.spuddyFollow = e.target.checked;
                        document.getElementById('spuddy-follower')?.classList.toggle('hidden', !state.spuddyFollow);
                    });
                });
            }
            document.addEventListener('mousemove', e => {
                if(state.spuddyFollow) { document.getElementById('spuddy-follower').style.transform = `translate(${e.clientX}px, ${e.clientY}px)`; }
            });

            // --- EASTER EGGS ---
            
            // Konami Code
            document.addEventListener('keydown', (e) => {
                // ... (konami logic unchanged)
                if (DOMElements.konamiSurprise.style.display === 'flex') return;
                const expectedKey = state.konamiCode[state.konamiIndex];
                
                if (e.key === expectedKey || e.key.toLowerCase() === expectedKey) {
                    state.konamiIndex++;
                    if (state.konamiIndex === state.konamiCode.length) {
                        DOMElements.konamiSurprise.style.display = 'flex';
                        state.konamiIndex = 0;
                         showNotification('KONAMI CODE ACCEPTED. EASTER EGG UNLOCKED!', 'success', 5000);
                    }
                } else {
                    state.konamiIndex = 0;
                }
            });
            
            // Search input
            DOMElements.mainSearchInput?.addEventListener('keypress', e => { 
                if (e.key === 'Enter') {
                    lagSimulatorInterceptor(() => { // NEW: Lag Sim
                        performSearch(e.target.value); 
                        e.target.value = '';
                    });
                }
            });
            
            // NEW: Funny Voice Search
            document.getElementById('voice-search')?.addEventListener('click', () => {
                lagSimulatorInterceptor(() => {
                    showNotification("I'm sorry, I only speak Tuber. Please potate your request.", 'info');
                });
            });

            // NEW: "BUY SPUDS" Cash Rain
            DOMElements.buySpudsInput?.addEventListener('keypress', e => {
                if (e.key === 'Enter' && e.target.value === 'BUY SPUDS') {
                    e.preventDefault();
                    lagSimulatorInterceptor(() => {
                        triggerCashRain();
                        state.userCash += 1000;
                        updatePortfolioUI();
                        showNotification('💸 CASH RAIN! +$1000! 💸', 'success', 4000);
                        e.target.value = '';
                    });
                }
            });
            
            function triggerCashRain() {
                if (!DOMElements.rainingCashContainer) return;
                for (let i = 0; i < 30; i++) {
                    const cash = document.createElement('div');
                    cash.textContent = '💸';
                    cash.className = 'cash-money';
                    cash.style.left = `${Math.random() * 100}vw`;
                    cash.style.animationDelay = `${Math.random() * 2}s`;
                    DOMElements.rainingCashContainer.appendChild(cash);
                    setTimeout(() => cash.remove(), 3000);
                }
            }
            
            // Secret Lab link
            let homeHoverTimeout;
            const homeNavLink = document.getElementById('home-nav-link');
            homeNavLink?.addEventListener('mouseenter', () => { homeHoverTimeout = setTimeout(() => { document.getElementById('secret-lab-link')?.classList.remove('hidden'); }, 5000); });
            homeNavLink?.addEventListener('mouseleave', () => { clearTimeout(homeHoverTimeout); });
            
            // Lawyer Mode
            document.addEventListener('keydown', (e) => {
                if (e.ctrlKey && e.altKey && e.key.toLowerCase() === 'p') {
                    if (state.currentPage === 'legal') document.getElementById('lawyer-mode-content')?.classList.toggle('hidden');
                }
            });
            
            // Footer click
            let footerClicks = 0;
            DOMElements.mainFooter?.addEventListener('click', () => {
                footerClicks++;
                if (footerClicks >= 10) { 
                    showNotification('POTATO EXPLOSION! 🥔💥', 'success', 5000);
                    spawnBouncingPotatoes(); 
                    footerClicks = 0; 
                }
            });

            // --- INITIALIZATION ---
            function init() {
                const initialPage = window.location.hash || '#home';
                showPage(initialPage);
                
                buildSearchIndex();
                attachNavListeners(DOMElements.navLinks); 
                
                renderProducts();
                renderNews();
                updateStockMarket();
                updateCart();
                updatePortfolioUI();
                initCatchGame();
                initClickerGame(); // NEW: Initialize clicker game

                setInterval(renderNews, 10000);
                setInterval(updateStockMarket, 2000);
            }

            init();
        });
    </script>
</body>
</html>
